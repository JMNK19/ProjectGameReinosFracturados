extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D

const cristal_sonido = preload("res://assets/sonido_coleccionables/cristal.mp3")

func _ready():
	animated_sprite_2d.play("default")
	
func _on_body_entered(body):
	if body.is_in_group("player") and animated_sprite_2d.animation == "default":
		_play_sound(cristal_sonido)
		animated_sprite_2d.play("recoger") #Animacion de recoger
		HealthDasboard.cristales += 1
		HealthDasboard.actualizar_cristales()
		await  audio_stream_player_2d.finished #Esperamos que termine el sonido
		self.queue_free() # Liberamos la memoria


func _play_sound(sound):
	# Pausamos el sonido
	audio_stream_player_2d.stop()
	# Reproducimos el sonido
	audio_stream_player_2d.stream = sound
	audio_stream_player_2d.play()
