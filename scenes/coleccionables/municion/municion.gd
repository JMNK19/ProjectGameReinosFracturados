extends Area2D

var tipo = "municion"

@onready var pocion = $AnimatedSprite2D
@onready var audio_item = $AudioStreamPlayer2D

const recoger_item_sonido = preload("res://assets/sonido_coleccionables/municion_02.mp3")

func _ready():
	pocion.play("default")


func _on_body_entered(body):
	if body.is_in_group("player") and pocion.animation == "default":
		_play_sound(recoger_item_sonido)
		pocion.play("recoger") #Animacion de recoger
		HealthDasboard.add_item_inventario(self)
		await  pocion.animation_finished #Esperamos que termine la anterior animación
		self.queue_free() # Liberamos la memoria

func get_texture() -> CompressedTexture2D:
	return $Sprite2D.texture

func _play_sound(sound):
	# Pausamos el sonido
	audio_item.stop()
	# Reproducimos el sonido
	audio_item.stream = sound
	audio_item.play()
