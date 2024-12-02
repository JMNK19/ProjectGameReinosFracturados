extends Node2D
@onready var collision_shape_2d_contexto = $Area2DContexto/CollisionShape2DContexto

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

# Nueva variable miembro para almacenar al "body"
var player_body = null

const BALLOON_SCENE = preload("res://scenes/dialogues/balloon/balloon.tscn")
var balloon = BALLOON_SCENE.instantiate()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_area_2d_contexto_body_entered(body):
	if body.is_in_group("player"):
		player_body=body
		body.Stop_enabled=true
		collision_shape_2d_contexto.queue_free()
		#DialogueManager.show_example_dialogue_balloon(load("res://scenes/dialogues/level_1/level1_asistente_inicio.dialogue"))
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)
		# Conectar la señal de fin de diálogo y activar el proceso físico
		balloon.dialogue_ended.connect(Callable(self, "_on_dialogue_ended"))

func _on_dialogue_ended():
	if player_body != null:
		# Activamos el proceso físico solo si la referencia al body existe
		player_body.Stop_enabled=false
		player_body = null # Limpiar la referencia para evitar posibles errores
