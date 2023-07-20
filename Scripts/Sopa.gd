extends Node
var tipo = "Sopa" #no pregunten y no juzgen xfavor
@onready var audio = $Audio
@onready var Anim = $AnimationPlayer
var daño = 17
const SPEED = 100.0
var lanzado = false
var tocoSuelo = false
var dir = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("Daños")
	self.get_node("Area2D/CollisionShape2D").disabled = true
	
func changePlayerTexture(jugador):
	jugador.armado = true
	if jugador.numJugador == 1:
		return preload("res://assets/characters/ChefV1_grabbing_soup.png")
	else:
		return preload("res://assets/characters/ChefV2_grabbing_soup.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if lanzado and tocoSuelo == false: 
		self.global_position = self.global_position + dir*SPEED*delta
	



func _lanzar(ultimoBoton):
	get_node("Sprite2D").visible = false
	get_node("Sprite2D2").visible = true
	Anim.play("sopa_lanzada")
	audio.play()
	dir = ultimoBoton
	lanzado = true


func _tocarSuelo():
	tocoSuelo = true
	self.get_node("Area2D/CollisionShape2D").disabled = false
	get_node("Sprite2D2").visible = false
	get_node("GPUParticles2D").emitting = true
	await get_tree().create_timer(0.5).timeout
	queue_free()

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
		
		

