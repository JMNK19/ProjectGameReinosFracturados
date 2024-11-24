extends AnimatedSprite2D
@onready var pantalla_pequenia = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pantalla_pequenia.play("estadisticas")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
