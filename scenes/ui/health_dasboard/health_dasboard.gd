extends CanvasLayer

# Variable (públicas) de vida y puntuación
var vida_total = 105 # Variable para menejo de vida

#Referenciamos la barra de vida
@onready var barra_vida = $BarraVida/TextureProgressBar


#Función de inicialización
func _ready():
	self.visible = true

func add_vida(vida: int):
	vida_total += vida
	if(vida_total > 105):
		vida_total = 105
	set_vida_progreso(vida_total)

func remove_vida(vida: int):
	vida_total -= vida
	if(vida_total < 0):
		vida_total = 0
	set_vida_progreso(vida_total)


func set_vida_progreso(vida: int):
	barra_vida.value = vida
