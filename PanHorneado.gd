extends Node
var tipo = "PanHorneado"
var golpesDados = 0
var daño = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("Daños")
	self.get_node("Area2D/CollisionShape2D").disabled = true





	
func iddle(jugador):
	get_node("Sprite2D").visible = false
	jugador.anim.play("iddle_panhorneado")
	
func run(jugador):
	get_node("Sprite2D").visible = false
	jugador.anim.play("run_panhorneado")
	


func atacar(jugador):
	jugador.animandose = true
	jugador.anim.play("atack_panhorneado")
	self.position = jugador.get_node("Sprite2D").position + jugador.ultimoBoton*10	
	self.get_node("Area2D/CollisionShape2D").disabled = false
	self.get_node("Area2D/CollisionShape2D").scale = Vector2(50000, 50000)
	#golpesDados += 1
	$attackSound.play()
	

func terminarAtacar(jugador):
	
	self.get_node("Area2D/CollisionShape2D").disabled = true
	jugador.anim.play("run")
	jugador.animandose = false
	if golpesDados >= 3:
		jugador.recibirIngrediente(null)
		self.queue_free()
		
