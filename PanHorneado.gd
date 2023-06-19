extends Node
var tipo = "PanHorneado"
var golpesDados = 0
var daño = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("Daños")
	self.get_node("Area2D/CollisionShape2D").disabled = true




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func iddle(jugador):
	get_node("Sprite2D").visible = false
	jugador.anim.play("iddle_panhorneado")
	
func run(jugador):
	get_node("Sprite2D").visible = false
	jugador.anim.play("run_panhorneado")
	


func atacar(jugador):
	get_node("Sprite2D").visible = false
	jugador.animandose = true
	jugador.anim.play("atack_panhorneado")
	self.position = jugador.get_node("Sprite2D").position + jugador.ultimoBoton*10	
	self.get_node("Area2D/CollisionShape2D").disabled = false
	golpesDados += 1

func terminarAtacar(jugador):
	#ingrediente.hide()#ocultamos el arma y desactivamos su hitbox
#	ingrediente.show()#mira esta wea solo pa testing lo dejare junto a la linea anterior
#	ingrediente.position = self.get_node("Sprite2D").position
#	ingrediente.get_node("Area2D/CollisionShape2D").disabled = true
#	animandose = false
#	anim.play("run")
	get_node("Sprite2D").visible = false
	self.get_node("Area2D/CollisionShape2D").disabled = true
	jugador.anim.play("run")
	jugador.animandose = false
	if golpesDados >= 3:
		jugador.recibirIngrediente(null)
		self.queue_free()
		
