extends Node2D

@onready var animation_player_control = $AnimationPlayerControl
@onready var animation_player_control_2 = $AnimationPlayerControl2
@onready var animation_player_portal_activado = $AnimationPlayerPortalActivado

@onready var area_2d_next_level = $Area2D_next_level
@onready var collision_shape_next_level = $Area2D_next_level/CollisionShapeNextLevel


# Called when the node enters the scene tree for the first time.
func _ready():
	HealthDasboard.visible=false
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

	

func _on_area_2d_next_level_body_entered(body):
	if body.is_in_group("player"):
		HealthDasboard.visible=true
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://scenes/levels/level_2/level_2.tscn")
