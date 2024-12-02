extends CharacterBody2D
#Referenciamos a la camara del nivel

const GRAVEDAD = 16

@export var speed: int = 50
@export var min_velocidad: int = 50
@export var max_velocidad: int = 100

@export var vida: int = 4
@export var daño_ataque: int = 20

@onready var can_move: bool = true

@onready var animacion = $AnimationPlayer
@onready var imagen = $Sprite2D
@onready var puntero_abajo = $Marker2D/RayCast2D
@onready var posicion_puntero = $Marker2D
@onready var puntero_patrulla = $Marker2D2/RayCast2D
@onready var posicion_patrulla = $Marker2D2
@onready var puntero_pared = $Marker2D3/RayCast2D
@onready var posicion_pared = $Marker2D3



# Definir enum con las opciones y valores
enum Direccion {
	IZQUIERDA = -1,
	DERECHA = 1
}

# Exportar la variable direccion con los valores del enum
@export var direccion: Direccion = Direccion.DERECHA

func _ready():
	animacion.play("run")
	if(direccion == -1):
		cambiar_posicion()

func cambiar_posicion():
	posicion_puntero.position.x *= -1
	posicion_patrulla.position.x *= -1
	puntero_patrulla.target_position.x *= -1
	posicion_pared.position.x *= -1
	puntero_pared.target_position.x *= -1

func _process(delta):
	# Solo si el personaje se puede mover, llamamos a su función que se encarga del movimiento
	if(can_move):
		movimiento_control(delta)
		patrulla_control()

func movimiento_control(delta):
	if(direccion > 0):
		imagen.flip_h = false
	elif(direccion < 0):
		imagen.flip_h = true
	if(puntero_pared.is_colliding()):
		if(puntero_pared.get_collider().is_in_group("entorno")):
			direccion *= -1
			cambiar_posicion()
	if(not puntero_abajo.is_colliding()):
		direccion *= -1
		cambiar_posicion()
	# Actualizar speed
	velocity.y += GRAVEDAD * delta  # Aplica la gravedad
	velocity.x = speed * direccion  # Movimiento horizontal
	
	# Aplicar movimiento
	move_and_slide()

func daño_control(daño: int):
	if vida > 0:
		vida -= daño #Restamos vida al enemigo con el daño recibido
		animacion.play("hit")
		#PONER SONIDO DE DAÑO
	else:
		animacion.play("dead")

func patrulla_control():
	if(puntero_patrulla.is_colliding()):
		if(puntero_patrulla.get_collider().is_in_group("player")):
			speed = max_velocidad
		else:
			speed = min_velocidad
	else:
		speed = min_velocidad

func _on_animation_player_animation_started(anim_name):
	match anim_name:
		"hit":
			can_move = false
		"dead":
			pass
			#PONER SONIDO DE DEAD


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"hit":
			if(vida > 0):
				can_move = true
				animacion.play("run")
			else:
				animacion.play("dead")
		"dead":
			queue_free()


func _on_area_2d_body_entered(body):
	if(body.is_in_group("player")):
		body.daño_control(daño_ataque)
