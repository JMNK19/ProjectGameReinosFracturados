extends Area2D

var tipo = "pocionVida"

@onready var pocion = $AnimatedSprite2D
@onready var audio = $AudioStreamPlayer2D

func _ready():
	pocion.play("default")


func _on_body_entered(body):
	if body.is_in_group("Jugador"):
		HealthDasboard.add_item_inventario(self)
		#audio.play()
		pocion.play("recoger") #Animacion de recoger
		await  pocion.animation_finished #Esperamos que termine la anterior animación
		self.queue_free() # Liberamos la memoria

func get_texture() -> CompressedTexture2D:
	return $Sprite2D.texture
