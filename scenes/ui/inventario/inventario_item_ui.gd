class_name InventarioItemUI extends Panel

func insertar(texture:CompressedTexture2D, cantidad: int):
	$TextureRect.texture = texture
	$Label.text = str(cantidad)

func actualizar(cantidad: int):
	$Label.text = str(cantidad)
