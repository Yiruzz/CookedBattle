extends Node
var tipo = "PanHorneado"
var golpesDados = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func iddle(jugador):
	jugador.anim.play("iddle_panhorneado")
	
func run(jugador):
	jugador.anim.play("run_panhorneado")
	


func atacar(jugador):
	jugador.animandose = true
	jugador.anim.play("atack_panhorneado")
	jugador.ingrediente.show()
	var area = self
	area.position = jugador.get_node("Sprite2D").position + jugador.ultimoBoton*10	
	jugador.get_node("Area2D/CollisionShape2D").disabled = false
	golpesDados += 1

func terminarAtacar(jugador):
	#ingrediente.hide()#ocultamos el arma y desactivamos su hitbox
#	ingrediente.show()#mira esta wea solo pa testing lo dejare junto a la linea anterior
#	ingrediente.position = self.get_node("Sprite2D").position
#	ingrediente.get_node("Area2D/CollisionShape2D").disabled = true
#	animandose = false
#	anim.play("run")
	jugador.anim.play("run")
	jugador.animandose = false
	if golpesDados >= 3:
		jugador.recibirIngrediente(null)
		self.queue_free()
		
