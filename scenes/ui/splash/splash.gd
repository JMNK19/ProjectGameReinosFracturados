extends Node2D

@onready var animation_player_endless = $AnimationPlayerEndless
@onready var animation_player_studio = $AnimationPlayerStudio
@onready var animation_player_utp = $AnimationPlayerUtp

# Ruta a la escena a cargar cuando finalice el "splash"
var _path_map_scene = "res://scenes/ui/main_menu/main_manu.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Escondemos la escena del menu
	HealthDasboard.visible = false
	# Mostramos el logo de Endless
	animation_player_studio.play("do_splash")

# Escuchamos el teclado
func _input(event):
	# Escuchamos si se preciona algun boton
	if event is InputEventKey:
		# Llamamos el la función de cambio de escena
		_go_title_screen()
		
# Redirect a la escena de Mapa
func _go_title_screen():
	# Pasamos a la escena de Menú principal
	SceneTransition.change_scene(_path_map_scene)

func _on_animation_player_studio_animation_finished(anim_name):
	animation_player_endless.play("do_splash")


func _on_animation_player_endless_animation_finished(anim_name):
	animation_player_utp.play("do_splash")


func _on_animation_player_utp_animation_finished(anim_name):
	_go_title_screen()
