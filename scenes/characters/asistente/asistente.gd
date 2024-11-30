extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var conversacion = $Area2D/conversacion

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
const BALLOON_SCENE = preload("res://scenes/dialogues/balloon/balloon.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 650

func _ready() -> void:
	
	animated_sprite_2d.play("idle")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		var movimiento=false
		body.set_physics_process(movimiento)
		conversacion.queue_free()
		#DialogueManager.show_example_dialogue_balloon(load("res://scenes/dialogues/level_1/level1_asistente_inicio.dialogue"))
		var balloon = BALLOON_SCENE.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)
		#aqui como hago para activar el body._physics_process(true) cuando acabe el dialogo?
		# Conectar la señal de fin de diálogo
		balloon.connect("dialogue_ended", Callable(self, _on_dialogue_ended(body)))
		
# Cuando termine el diálogo, reactivamos el _physics_process
func _on_dialogue_ended(body):
	body.set_physics_process(true)
