extends Control





func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_1/level_1.tscn")
	

func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu/Credits.tscn")
	
	
func _on_salir_pressed():
	get_tree().quit()