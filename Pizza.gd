extends Node
var tipo = "Pizza"
var daño = 14
const SPEED = 140.0
var lanzado = false
var dir = Vector2(0,0)
@onready var audio = $Audio
@onready var Anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("Daños")
	self.get_node("Area2D/CollisionShape2D").disabled = true
	

func changePlayerTexture(numJugador):
	if numJugador == 1:
		return preload("res://assets/characters/ChefV1_grabbing_pizza.png")
	else:
		return preload("res://assets/characters/ChefV2_grabbing_pizza.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if lanzado: 
		self.global_position = self.global_position + dir*SPEED*delta
	

func _lanzar(ultimoBoton):
	audio.play()
	Anim.play("pizza_girando")
	dir = ultimoBoton
	lanzado = true

func atacar(jugador):
	jugador.animandose = true
	jugador.anim.play("melee_atack")
	var new_parent = get_parent().get_parent()
	get_parent().remove_child(self)
	new_parent.add_child(self)
	self.scale.x = 1
	self.scale.y = 1	
	self.global_position  = jugador.get_node("Sprite2D").global_position + jugador.ultimoBoton*50	
	_lanzar(jugador.ultimoBoton)	
	self.get_node("Area2D/CollisionShape2D").disabled = false
	jugador.defaultTexture(jugador.numJugador)


func terminarAtacar(jugador):
	#ingrediente.hide()#ocultamos el arma y desactivamos su hitbox
#	ingrediente.show()#mira esta wea solo pa testing lo dejare junto a la linea anterior
#	ingrediente.position = self.get_node("Sprite2D").position
#	ingrediente.get_node("Area2D/CollisionShape2D").disabled = true
#	animandose = false
#	anim.play("run")
	jugador.anim.play("run")
	jugador.animandose = false
	jugador.ingrediente = null
		
		


func _on_area_2d_body_entered(body):
	if lanzado:
		self.queue_free()
