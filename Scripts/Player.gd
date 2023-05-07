extends CharacterBody2D


const SPEED = 200.0
@export var Vida = 100
@onready var anim = $AnimationPlayer
@export var BtnDer = "ui_right"
@export var BtnIzq = "ui_left"
@export var BtnArr = "ui_up"
@export var BtnAbj = "ui_down"
@export var BtnAttck = "ui_attack"
@export var BtnTesting = "ui_test"
@export var ingrediente = preload("res://pan.tscn")
var animandose = false
var ultimoBoton = Vector2(1,0)
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


#Funcion que se llama al inicio de la partida
func _ready():
	self.get_node("Area2D").hide()#ocultamos el arma y desactivamos su hitbox
	self.get_node("Area2D/CollisionShape2D").disabled = true
	if ingrediente != null:
		ingrediente = ingrediente.instantiate()
		add_child(ingrediente)
	
	
	
	


#Funcion que se llama para atacar con el dispatch del enemigo
func atacar(Enemigo):
	Enemigo.Vida = Enemigo.Vida - 10
	


#Funcion que se llama para quitar vida al personaje de este objeto
func recibirDaño():
	Vida = Vida - 10
	if Vida <= 0:
		print("The player is dead")
	else:
		print(str(Vida) + " " + self.get_node(".").name)
	

#Funcion que posiciona la hitbox del ataque cuerpo a cuerpo
func posicionarAtaque(direccion):
	anim.play("melee_atack")
	ingrediente.show()
	var area = ingrediente
	area.position = self.get_node("Sprite2D").position + direccion*10	
	self.get_node("Area2D/CollisionShape2D").disabled = false
	
func _terminarAtaqueMelee():
	ingrediente.hide()#ocultamos el arma y desactivamos su hitbox
	ingrediente.show()#mira esta wea solo pa testing lo dejare junto a la linea anterior
	ingrediente.position = self.get_node("Sprite2D").position
	ingrediente.get_node("Area2D/CollisionShape2D").disabled = true
	animandose = false
	anim.play("run")
	
	
#Funcion que entrega un ingrediente a una herramienta de cocina
func entregaIngrediente(Cocina):
	Cocina.RecibirIngrediente(ingrediente)
	pass

func recibirIngrediente(Ingrediente):
	ingrediente = Ingrediente
	print("recogido")
	if ingrediente != null:
		add_child(ingrediente)
	pass
	
#Funcion que recibe una señal de un input cualquiera
func _input(event):
	if event.is_action_pressed(BtnAttck): #Caso se ataca, se obtiene la direccion a atacar
		var dir = Vector2(Input.get_axis(BtnIzq, BtnDer),Input.get_axis(BtnArr, BtnAbj))
		if dir.length() == 0: #si no se proporciona direccion se usa la ultima direccion elegida
			dir = ultimoBoton
		animandose = true
		posicionarAtaque(dir)
		ultimoBoton = dir
		
	if event.is_action_pressed(BtnTesting): #Solo pa la demo
		if ingrediente!=null:
			self.get_node("Area2D").hide()#ocultamos el arma y desactivamos su hitbox
			self.get_node("Area2D/CollisionShape2D").disabled = true
		else:
			self.get_node("Area2D").show()#ocultamos el arma y desactivamos su hitbox
			self.get_node("Area2D/CollisionShape2D").disabled = false


#
func _physics_process(delta):
	var dir = Vector2(Input.get_axis(BtnIzq, BtnDer),Input.get_axis(BtnArr, BtnAbj))
	velocity = dir*SPEED
	
	if !animandose: 
		if (velocity.length() > 0 ):
			anim.play("run")
			if(velocity.x > 0):
				$Sprite2D.flip_h = false
			else:
				$Sprite2D.flip_h = true
		else:
			anim.play("Idle")
	move_and_slide()
	




func _on_area_2d_body_entered(body):
	if !body.is_in_group(self.get_groups()[0]):
		if body.is_in_group("Players"):
			body.recibirDaño()
		
