extends Area2D

@export var path_nivel:String

@onready var animated_sprite_2d = $AnimatedSprite2D


func _ready():
	animated_sprite_2d.play("default")



func _on_body_entered(body):
	if(body.is_in_group("player")):
		SceneTransition.change_scene(path_nivel)
