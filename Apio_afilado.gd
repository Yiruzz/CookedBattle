extends Node2D
var tipo = "ApioAfilado"
var golpesDados = 0
var daño = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("Daños")
	self.get_node("Area2D/CollisionShape2D").disabled = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func dannar_arma():
	self.golpesDados += 1

func atacar(jugador):
	jugador.animandose = true
	jugador.anim.play("melee_atack")
	self.position = jugador.get_node("Sprite2D").position + jugador.ultimoBoton*10	
	self.get_node("Area2D/CollisionShape2D").disabled = false
	#golpesDados += 1
	$attackSound.play()

func terminarAtacar(jugador):
	#ingrediente.hide()#ocultamos el arma y desactivamos su hitbox
#	ingrediente.show()#mira esta wea solo pa testing lo dejare junto a la linea anterior
#	ingrediente.position = self.get_node("Sprite2D").position
#	ingrediente.get_node("Area2D/CollisionShape2D").disabled = true
#	animandose = false
#	anim.play("run")
	self.get_node("Area2D/CollisionShape2D").disabled = true
	jugador.anim.play("run")
	jugador.animandose = false
	if golpesDados >= 1:
		jugador.recibirIngrediente(null)
		self.queue_free()
		jugador.defaultTexture(jugador.numJugador)

func changePlayerTexture(jugador):
	self.visible = false
	jugador.armado = true
	if jugador.numJugador == 1:
		return preload("res://assets/characters/ChefV1_grabbing_asparagus_sword.png")
	else:
		return preload("res://assets/characters/ChefV2_grabbing_asparagus_sword.png")
