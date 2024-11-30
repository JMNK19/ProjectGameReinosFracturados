extends Control

func add_portrait(portrait):
	var portrait_path:String ="res://assets/asistente/asistente quieto-Sheet.png" % portrait.id
	if FileAccess.file_exists(portrait_path):
		$image.texture = load(portrait_path)
	else:
		$image.texture = null
	
func add_portrait_id(id:String):
	var portrait_path:String ="res://assets/asistente/asistente quieto-Sheet.png" % id
	if FileAccess.file_exists(portrait_path):
		$image.texture = load(portrait_path)
	else:
		$image.texture = null

func remove_portrait():
	$contorn.texture = null
	$image.texture = null
	
func set_color(color:Color):
	$contorn.modulate = color
