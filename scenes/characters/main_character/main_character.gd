extends CharacterBody2D

@export var gravity = 650
@export var jump_speed = 250
@export var speed = 100
@export var max_jumps = 2 # Número máximo de saltos permitidos
@onready var animated_sprite_2d = $AnimatedSprite2D

var _current_movement = "idle"
var jump_count = 0 # Contador de saltos

func _ready():
	animated_sprite_2d.play("idle")

func _physics_process(delta):
	# horizontal
	var direction = Input.get_axis("izquierda", "derecha")
	velocity.x = speed * direction

	# Cambiar animación a "run" si hay movimiento horizontal
	if direction != 0:
		animated_sprite_2d.scale.x = direction
		if _current_movement != "run" and is_on_floor():
			_current_movement = "run"
			animated_sprite_2d.play("run")
	else:
		# Volver a "idle" si no hay movimiento horizontal
		if _current_movement != "idle" and is_on_floor():
			_current_movement = "idle"
			animated_sprite_2d.play("idle")

	# gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Verificar si está en el suelo para reiniciar el contador de saltos
	if is_on_floor():
		jump_count = 0

	# saltar
	var jump_pressed = Input.is_action_just_pressed("saltar")
	if jump_pressed and jump_count < max_jumps:
		velocity.y = -jump_speed
		jump_count += 1
		# Cambiar a animación de salto
		if _current_movement != "jump":
			_current_movement = "jump"
			animated_sprite_2d.play("jump")

	# Cambiar a animación de caída si no está en el suelo y no está saltando
	if not is_on_floor() and velocity.y > 0 and _current_movement != "fall":
		_current_movement = "fall"
		animated_sprite_2d.play("fall")

	move_and_slide()


