extends AnimatedSprite2D

@onready var pantalla_grande = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pantalla_grande.play("datos")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass