extends Node
var tipo = "Pizza"
var daño = 25
const SPEED = 50.0
var lanzado = false
var dir = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("Daños")
	self.get_node("Area2D/CollisionShape2D").disabled = true
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if lanzado: 
		self.global_position = self.global_position + dir*SPEED*delta
	

func _lanzar(ultimoBoton):
	dir = ultimoBoton
	lanzado = true

func atacar(jugador):
	jugador.animandose = true
	jugador.anim.play("melee_atack")
	var new_parent = get_parent().get_parent()
	get_parent().remove_child(self)
	new_parent.add_child(self)
	
	self.global_position  = jugador.get_node("Sprite2D").global_position + jugador.ultimoBoton*50	
	_lanzar(jugador.ultimoBoton)	
	self.get_node("Area2D/CollisionShape2D").disabled = false


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
