extends Area2D

var direction: int

@onready var can_move: bool = true
@onready var animacion = $AnimatedSprite2D

func _ready():
	animacion.play("default")

func _process(delta):
	if can_move:
		global_position.x += direction*delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() #Eliminamos el disparo cuando sale de la pantalla


func _on_body_entered(body):
	if(body.is_in_group("enemy")): #verificamos si es un enemigo
		body.hit(1) #llamamos a la función para hacer daño al enemigo
		animacion.play("explosion") #Animar explosion
		can_move = false
	elif(body.is_in_group("entorno")):
		animacion.play("explosion")#Animar explosion
		can_move = false


func _on_animated_sprite_2d_animation_finished():
	if(animacion.animation == "explosion"):
		queue_free()
