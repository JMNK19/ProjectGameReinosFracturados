class_name InventarioItemUI extends Panel

func insertar(texture:CompressedTexture2D, cantidad: int, tecla: String):
	$TextureRect.texture = texture
	$Cantidad.text = str(cantidad)
	$Tecla.text = tecla

func actualizar(cantidad: int):
	$Cantidad.text = str(cantidad)
