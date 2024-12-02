extends PanelContainer

var tecla: String = ""

@onready var contenedor = $HBoxContainer

const INVENTARIO_ITEM_UI = preload("res://scenes/ui/inventario/inventario_item_ui.tscn")

func add_item(tipo, texture: CompressedTexture2D, cantidad: int):
	var nombre_nodo = "inventario_item_"+str(tipo)
	if not contenedor.has_node(nombre_nodo):
		var inventario_item = INVENTARIO_ITEM_UI.instantiate()
		inventario_item.name = nombre_nodo
		if(tipo == "pocionVida"):
			tecla = "F"
		else:
			tecla = "R"
		inventario_item.insertar(texture, cantidad, tecla)
		contenedor.add_child(inventario_item)
	else:
		var nodo_existente = contenedor.get_node(nombre_nodo)
		nodo_existente.actualizar(cantidad)
		


func _on_canvas_layer_item_added(item, cantidad):
	add_item(item.tipo, item.get_texture(), cantidad)


func _on_canvas_layer_item_consumed(tipo, cantidad):
	var nombre_nodo = "inventario_item_"+str(tipo)
	if contenedor.has_node(nombre_nodo):
		var nodo_existente = contenedor.get_node(nombre_nodo)
		if cantidad > 0:
			nodo_existente.actualizar(cantidad)
		else:
			nodo_existente.queue_free()

func eliminar_inventario():
	for child in contenedor.get_children():
		child.queue_free()

func _on_canvas_layer_restart_inventario():
	eliminar_inventario()
