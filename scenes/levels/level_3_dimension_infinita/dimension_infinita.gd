extends Node2D
@onready var label_2 = $Label2


# Called when the node enters the scene tree for the first time.
func _ready():
	HealthDasboard.visible=false
	await get_tree().create_timer(3).timeout
	label_2.visible=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
