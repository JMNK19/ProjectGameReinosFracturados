extends Node2D
@onready var puerta = $puerta
@onready var collision_shape_2d = $CollisionShape2D
@onready var audio_stream_player = $AudioStreamPlayer
@onready var restringido = $Restringido
@onready var concedido = $Concedido
@onready var timer = $Timer





# Called when the node enters the scene tree for the first time.
func _ready():
	puerta.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	if body.is_in_group("player"):
		collision_shape_2d.queue_free()
		puerta.play("open")
		restringido.visible=false
		audio_stream_player.play()
		concedido.visible=true
		
	pass # Replace with function body.
