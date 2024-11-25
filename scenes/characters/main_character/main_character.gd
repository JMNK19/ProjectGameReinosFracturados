class_name Personaje
extends CharacterBody2D

@export var gravity = 650
@export var jump_speed = 250
@export var speed = 100
@onready var animated_sprite_2d = $AnimatedSprite2D

var jump_count = 0 # Contador de saltos

func _physics_process(delta):
	
	#horizontal
	var direction = Input.get_axis("izquierda","derecha")
	velocity.x = speed * direction
	
	if direction !=0:
		animated_sprite_2d.scale.x = direction
		#Para invertir la direccion
		#sprite_2d.scale.x = abs(sprite_2d.scale.x) * -sign(direction)
	#gravedad
	if not is_on_floor():
		velocity.y = velocity.y + gravity * delta
	
	#saltar
	var jump_pressed = Input.is_action_just_pressed("saltar")
	if jump_pressed:
		velocity.y = velocity.y - jump_speed

	move_and_slide()
