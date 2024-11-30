extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var conversacion = $Area2D/conversacion


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 650

func _ready():
	animated_sprite_2d.play("idle")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		conversacion.queue_free()
		DialogueManager.show_example_dialogue_balloon(load("res://scenes/dialogues/level_1/level1_asistente_inicio.dialogue"))
		
		pass # Replace with function body.