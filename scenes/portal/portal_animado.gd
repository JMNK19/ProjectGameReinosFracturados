extends Area2D
@onready var portal = $portal
@onready var audio_stream_player = $portal/AudioStreamPlayer
@onready var collision_shape_2d = $CollisionShape2D
@onready var animation_player_portal_creciente = $AnimationPlayerPortalCreciente



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("player"):
		collision_shape_2d.queue_free()
		portal.visible=true
		animation_player_portal_creciente.play("creciente")
		audio_stream_player.play()
		portal.play("animacion")
