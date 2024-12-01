extends Timer

# Se define una señal que será emitida cuando el temporizador termine
signal disparo_permitido

func _ready():
	# Configuración del Timer
	wait_time = 0.2  # Tiempo entre disparos (2 segundos)
	one_shot = true  # El temporizador solo se ejecuta una vez
	
func _on_timeout():
	# Emitir la señal cuando el temporizador termine
	emit_signal("disparo_permitido")
