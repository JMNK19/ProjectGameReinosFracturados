extends CanvasLayer

signal item_added(item, cantidad:int)
signal item_consumed(tipo, cantidad:int)

# Variable (públicas) de vida y puntuación
var vida_actual = 105 # Variable para menejo de vida
var municion_actual = 11 # Variable para manejo de la munición
var min_vida = 0
var min_municion = 0
var max_vida = 105
var max_municion = 11

var inventario = {}

#Referenciamos la barra de vida
@onready var barra_vida = $BarraVida/TextureProgressBar
@onready var barra_municion = $BarraMunicion/TextureProgressBar


#Función de inicialización
func _ready():
	self.visible = true

#FUNCIONES PARA GESTIONAR LA VIDA DEL JUGADOR
func add_vida(vida: int):
	vida_actual += vida
	if(vida_actual > max_vida):
		vida_actual = max_vida
	set_vida_progreso(vida_actual)

func remove_vida(vida: int):
	vida_actual -= vida
	if(vida_actual < min_vida):
		vida_actual = min_vida
	set_vida_progreso(vida_actual)

func set_vida_progreso(vida: int):
	barra_vida.value = vida

#FUNCIONES PARA GESTIONAR LA MUNICIÓN DEL JUGADOR
func add_municion(municion: int):
	municion_actual += municion
	if(municion_actual > max_municion):
		municion_actual = max_municion
	set_municion_progreso(municion_actual)

func remove_municion(municion: int):
	municion_actual -= municion
	if(municion_actual < 0):
		municion_actual = min_municion
	set_municion_progreso(municion_actual)

func set_municion_progreso(municion: int):
	barra_municion.value = municion

#FUNCIONES PARA GESTIONAR EL INVENTARIO DEL JUGADOR
func add_item_inventario(item):
	if not inventario.has(item.tipo):
		inventario[item.tipo] = 1
	else:
		inventario[item.tipo] += 1
	item_added.emit(item, inventario[item.tipo])

func consumir_item(tipo):
	if inventario.has(tipo):
		inventario[tipo] -= 1
		item_consumed.emit(tipo, inventario[tipo])
		if(inventario[tipo] <= 0):
			inventario.erase(tipo)
	
