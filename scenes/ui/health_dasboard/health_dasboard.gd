extends CanvasLayer

signal item_added(item, cantidad:int)
signal item_consumed(tipo, cantidad:int)
signal restart_inventario()

# Variable (públicas) de vida y puntuación
var vida_actual = 105 # Variable para menejo de vida (105 -> 100%)
var municion_actual = 77 # Variable para manejo de la munición (77 -> 100%)
var min_vida = 0
var min_municion = 0
var max_vida = 105
var max_municion = 77

var cristales = 0

var municion_disponible:bool = true

var inventario = {}

#Referenciamos la barra de vida
@onready var barra_vida = $BarraVida/TextureProgressBar
@onready var barra_municion = $BarraMunicion/TextureProgressBar
@onready var audio_items = $AudioStreamPlayer2D
@onready var cantidad_cristales_label = $Coleccionables/Label


const laser_sonido = preload("res://assets/sonido_laser/laser_01.mp3")
const laser_sin_municion_sonido = preload("res://assets/sonido_laser/laser_sin_municion.mp3")
const sin_municion_sonido = preload("res://assets/sonido_laser/sin_municion.mp3")

const pocionVida_sonido = preload("res://assets/sonido_coleccionables/pocionVida.mp3")
const municion_sonido = preload("res://assets/sonido_coleccionables/recargarPistolaLaser.mp3")

#Función de inicialización
func _ready():
	barra_vida.value = vida_actual
	barra_municion.value = municion_actual
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
	municion_disponible = true
	set_municion_progreso(municion_actual)

func remove_municion(municion: int):
	
	if(municion_actual > min_municion):
		_play_sound(laser_sonido)
		
	municion_actual -= municion
	
	if(municion_actual < min_municion):
		municion_actual = min_municion
		_play_sound(laser_sin_municion_sonido)
		municion_disponible = false
	elif(municion_actual == min_municion):
		var timer = Timer.new()
		add_child(timer)  # Añadir el temporizador a la escena
		timer.wait_time = 0.4  # Establecer el tiempo de espera (1 segundo)
		timer.one_shot = true  # El temporizador se dispara solo una vez
		timer.start()  # Iniciar el temporizador
		
		# Esperar a que termine el temporizador
		await timer.timeout
		_play_sound(sin_municion_sonido)
		
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
		if(tipo == "pocionVida"):
			_play_sound(pocionVida_sonido)
			add_vida(50)
		elif(tipo == "municion"):
			_play_sound(municion_sonido)
			add_municion(77)
		else:
			pass
		item_consumed.emit(tipo, inventario[tipo])
		if(inventario[tipo] <= 0):
			inventario.erase(tipo)

func _play_sound(sound):
	# Pausamos el sonido
	audio_items.stop()
	# Reproducimos el sonido
	audio_items.stream = sound
	audio_items.play()

func restart():
	vida_actual = max_vida
	set_vida_progreso(vida_actual)
	municion_actual = max_municion
	set_municion_progreso(municion_actual)
	inventario = {}
	restart_inventario.emit()


func actualizar_cristales():
	cantidad_cristales_label.text = str(cristales)
