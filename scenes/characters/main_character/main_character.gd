extends CharacterBody2D

@export var gravity = 650
@export var jump_speed = 250
@export var speed = 130
@export var max_jumps = 2 # Número máximo de saltos permitidos
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var audio_player= $AudioStreamPlayer2D
@onready var disparo_timer = $Timer
@onready var animation_player = $AnimationPlayer



#Escena del disparo
const disparo = preload("res://scenes/characters/main_character/Disparo/disparo.tscn")
const daño_cientifico_sonido = preload("res://assets/sounds/daño_cientifico.mp3")
const game_over_sonido = preload("res://assets/sounds/game_over.mp3")

# Variable para controlar si el jugador puede disparar
var can_shoot = true
var Stop_enabled = false

var _current_movement = "idle"
var jump_count = 0 # Contador de saltos
var _run_sound = preload("res://assets/sounds/walking1.mp3")

var is_walking_sound_playing = false

var inmunidad: bool = false
var dead: bool = false

func _ready():
	animated_sprite_2d.play("idle_with_arma")

#Actualmente uso esta funcion para la puerta del laboratorio
func _process(delta):
	stop_character()

func _physics_process(delta):
	if(dead):
		
		return
	# Horizontal
	var direction = Input.get_axis("izquierda", "derecha")
	velocity.x = speed * direction

	# Reproducir sonido de caminar si está moviéndose y en el suelo
	if direction != 0 and is_on_floor():
		if not is_walking_sound_playing:
			_play_sound(_run_sound)
			is_walking_sound_playing = true
	else:
		if is_walking_sound_playing:
			audio_player.stop()
			is_walking_sound_playing = false

	# Cambiar animación a "run" si hay movimiento horizontal
	if direction != 0:
		animated_sprite_2d.scale.x = direction
		if _current_movement != "run" and is_on_floor():
			_current_movement = "run"
			animated_sprite_2d.play("run_with_arma")
	else:
		# Volver a "idle" si no hay movimiento horizontal
		if _current_movement != "idle" and is_on_floor():
			_current_movement = "idle"
			animated_sprite_2d.play("idle_with_arma")

	# Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Verificar si está en el suelo para reiniciar el contador de saltos
	if is_on_floor():
		jump_count = 0

	# Saltar
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
	
	if dead: # Si el personaje murió, no se podrá mover en el eje X
		velocity.x = 0
	move_and_slide()

func _unhandled_input(event):
	if(event.is_action_released("curar")):
		velocity.x = 0
		HealthDasboard.consumir_item("pocionVida")
	elif(event.is_action_released("recargar")):
		velocity.x = 0
		HealthDasboard.consumir_item("municion")
	elif(event.is_action_pressed("disparar") and can_shoot):
		velocity.x = 0
		HealthDasboard.remove_municion(7)
		if(HealthDasboard.municion_disponible):
			disparar_control()
		can_shoot = false  # Desactivar el disparo temporalmente
		disparo_timer.start()  # Iniciar el temporizador para permitir disparar nuevamente después de 2 segundos


func _on_audio_stream_player_2d_finished():
	if audio_player.stream == game_over_sonido:
		# Qitamos al personaje principal de la excena
		queue_free()
		# Reiniciamos el juego despues de 2 segundos
		SceneTransition.reload_scene()

func disparar_control():
	var laser = disparo.instantiate()
	
	if(animated_sprite_2d.scale.x < 0):
		laser.global_position = Vector2($PosicionDisparo.global_position.x-20, $PosicionDisparo.global_position.y)
		laser.scale.x = -1
		laser.direction = -224
	elif(animated_sprite_2d.scale.x > 0):
		laser.global_position = Vector2($PosicionDisparo.global_position.x+20, $PosicionDisparo.global_position.y)
		laser.scale.x = 1
		laser.direction = 224
	
	get_tree().call_group("nivel", "add_child", laser)

func daño_control(daño:int):
	if(inmunidad == false):
		HealthDasboard.remove_vida(daño)
		if(HealthDasboard.vida_actual>0):
			_play_sound(daño_cientifico_sonido)
			animation_player.play("hit")
			inmunidad = true
			speed = 150
		else:
			dead = true
			animation_player.play("dead")

func _play_sound(sound):
	# Pausamos el sonido
	audio_player.stop()
	# Reproducimos el sonido
	audio_player.stream = sound
	audio_player.play()
	
func stop_character():
	if Stop_enabled==true:
		audio_player.stop()
		animated_sprite_2d.play("idle_with_arma")
		set_physics_process(false)
	else:
		set_physics_process(true)

func _on_timer_disparo_permitido():
	# Esta función es llamada cuando el temporizador finaliza
	can_shoot = true  # Permitir disparar nuevamente


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"hit":
			speed = 130
			inmunidad = false


func _on_animation_player_animation_started(anim_name):
	match anim_name:
		"dead":
			_play_sound(game_over_sonido)
