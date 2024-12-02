extends Control
@onready var instrucciones = $instrucciones
@onready var creditos = $creditos

func _ready():
	HealthDasboard.visible=false

func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_1/level_1.tscn")
	

func _on_creditos_pressed():
	creditos.visible=true
	#get_tree().change_scene_to_file("res://scenes/ui/main_menu/Credits.tscn")
	
	
func _on_salir_pressed():
	get_tree().quit()


func _on_instrucciones_pressed():
	instrucciones.visible=true
	#get_tree().change_scene_to_file("res://scenes/ui/main_menu/Instrucciones.tscn")


func _on_atras_pressed():
	instrucciones.visible=false


func _on_atras_creditos_pressed():
	creditos.visible=false
