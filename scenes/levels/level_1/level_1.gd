extends Node2D

@onready var animation_player_control = $AnimationPlayerControl
@onready var animation_player_control_2 = $AnimationPlayerControl2
@onready var animation_player_portal_activado = $AnimationPlayerPortalActivado


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player_control.play("controles")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_control_animation_finished(anim_name):
	animation_player_control_2.play("Controles")
	pass # Replace with function body.


func _on_area_2d_portal_activado_body_entered(body):
	if body.is_in_group("player"):
		animation_player_portal_activado.play("portal_activado") # Replace with function body.
