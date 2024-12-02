extends CharacterBody2D
#Referenciamos a la camara del nivel
class_name basic_enemy

const GRAVEDAD = 16
@export var velocidad: int = 48

@export var vida: int = 4
@export var daño_ataque: int = 5

@onready var can_move: bool = true

@onready var animacion = $AnimationPlayer
@onready var imagen = $Sprite2D
@onready var puntero_abajo = $Marker2D/RayCast2D
@onready var posicion_puntero = $Marker2D

# Definir enum con las opciones y valores
enum Direccion {
	IZQUIERDA = -1,
	DERECHA = 1
}

# Exportar la variable direccion con los valores del enum
@export var direccion: Direccion = Direccion.DERECHA

func _ready():
	animacion.play("run")

func _process(delta):
	# Solo si el personaje se puede mover, llamamos a su función que se encarga del movimiento
	if(can_move):
		movimiento_control(delta)

func movimiento_control(delta):
	if(direccion > 0):
		imagen.flip_h = false
	elif(direccion < 0):
		imagen.flip_h = true
	
	if(is_on_wall() or not puntero_abajo.is_colliding()):
		direccion *= -1
		posicion_puntero.position *= -1
	# Actualizar velocidad
	velocity.y += GRAVEDAD * delta  # Aplica la gravedad
	velocity.x = velocidad * direccion  # Movimiento horizontal
	
	# Aplicar movimiento
	move_and_slide()

func daño_control(daño: int):
	if vida > 0:
		vida -= daño #Restamos vida al enemigo con el daño recibido
		animacion.play("hit")
		#PONER SONIDO DE DAÑO
	else:
		animacion.play("dead")


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
