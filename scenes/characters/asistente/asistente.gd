extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var conversacion = $Area2D/conversacion

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

# Nueva variable miembro para almacenar al "body"
var player_body = null

const BALLOON_SCENE = preload("res://scenes/dialogues/balloon/balloon.tscn")
const SPEED = 110.0
const JUMP_VELOCITY = 250

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 650
var balloon = BALLOON_SCENE.instantiate()
func _ready() -> void:
	animated_sprite_2d.play("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		#print("ingreso")
		player_body=body
		body.Stop_enabled=true
		conversacion.queue_free()
		#DialogueManager.show_example_dialogue_balloon(load("res://scenes/dialogues/level_1/level1_asistente_inicio.dialogue"))
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)
		# Conectar la señal de fin de diálogo y activar el proceso físico
		balloon.dialogue_ended.connect(Callable(self, "_on_dialogue_ended"))
		#aqui como hago para activar el body.set_physics_process(true) cuando acabe el dialogo?
		
func _on_dialogue_ended():
	if player_body != null:
		# Activamos el proceso físico solo si la referencia al body existe
		player_body.Stop_enabled=false
		move_right()
		player_body = null # Limpiar la referencia para evitar posibles errores
		
# Método para mover al personaje hacia la derecha
func move_right():
	# Establecer la velocidad de movimiento hacia la derecha
	velocity.x = SPEED  # Movimiento constante hacia la derecha

	# Cambiar la animación para que el personaje camine hacia la derecha
	animated_sprite_2d.scale.x = 1  # Asegurarse de que el personaje mire hacia la derecha
	if animated_sprite_2d.animation != "run":
		animated_sprite_2d.play("run")  # Cambiar a la animación de correr

func stop():
	# Detener el movimiento horizontal
	velocity.x = 0  # Detener la velocidad en el eje X

	# Cambiar la animación a "idle" o reposo
	animated_sprite_2d.play("idle")  # Reproducir la animación de reposo

	# Si es necesario, puedes agregar más lógica para detener cualquier otro comportamiento del personaje
