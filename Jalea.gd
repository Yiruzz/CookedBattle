extends Node
var tipo = "Jalea" #no pregunten y no juzgen xfavor
#var daño = 15
const SPEED = 50.0
var lanzado = false
var dir = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	#self.add_to_group("Daños")
	self.get_node("Area2D/CollisionShape2D").disabled = true
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
		
	

func _lanzar():
	lanzado = true
	self.scale.x = 1
	self.scale.y = 1
	await get_tree().create_timer(60.0).timeout
	queue_free()
	
	
func atacar(jugador):
	jugador.animandose = true
	jugador.anim.play("melee_atack")
	
	var new_parent = get_parent().get_parent()
	get_parent().remove_child(self)
	new_parent.add_child(self)

	self.global_position  = jugador.get_node("Sprite2D").global_position
	
	_lanzar()	
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
	if lanzado and !self.is_in_group(body.get_groups()[0]):
		if body.baseSpeed == body.SPEED:
			body.setSpeed(body.SPEED/10)





func _on_area_2d_body_exited(body):
	if lanzado and !self.is_in_group(body.get_groups()[0]):	
		if body.baseSpeed != body.SPEED:
			body.setSpeed(body.SPEED*10)

