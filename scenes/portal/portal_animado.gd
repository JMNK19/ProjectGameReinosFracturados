extends Area2D
@onready var portal = $portal
@onready var audio_stream_player = $portal/AudioStreamPlayer
@onready var collision_shape_2d = $CollisionShape2D
@onready var animation_player_portal_creciente = $AnimationPlayerPortalCreciente

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


func _on_body_entered(body):
	if body.is_in_group("asistente"):
		#print("ingreso asistente")
		body.animated_sprite_2d.scale.x = -1
		await get_tree().create_timer(1.0).timeout
		body.stop()
		
		
	if body.is_in_group("player"):
		body.Stop_enabled=true
		player_body=body
		collision_shape_2d.queue_free()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)
		portal.visible=true
		animation_player_portal_creciente.play("creciente")
		audio_stream_player.play()
		portal.play("animacion")
		# Conectar la señal de fin de diálogo y activar el proceso físico
		balloon.dialogue_ended.connect(Callable(self, "_on_dialogue_ended"))
		#aqui como hago para activar el body.set_physics_process(true) cuando acabe el dialogo?

func _on_dialogue_ended():
	if player_body != null:
		# Activamos el proceso físico solo si la referencia al body existe
		player_body.Stop_enabled=false
		player_body = null # Limpiar la referencia para evitar posibles errores
