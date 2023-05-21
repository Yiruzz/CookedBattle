extends Node

@onready var Anim = $AnimationPlayer
var listaIngredientes = []

var ingredienteListo = false
var ingredienteARecoger = null
var porcentajeDePicado

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func recibirIngrediente(ingrediente):
	listaIngredientes.append(ingrediente.tipo)
	if (listaIngredientes.size() >= 1):
		_receta()
		cocinarIngrediente()
		listaIngredientes = []
	
func picar():
	porcentajeDePicado += 10
	if porcentajeDePicado >= 100:
		terminarCocina()
	
func _receta():
	if listaIngredientes.count("Apio") == 1: #Se cocina un apio afilado
		ingredienteARecoger = preload("res://pan_horneado.tscn").instantiate()
	if listaIngredientes.count("Tomate") == 1: #Se cocina un tomate picado
		ingredienteARecoger = preload("res://pan_horneado.tscn").instantiate()

func cocinarIngrediente():
	print("empezo")
	Anim.play("Cocinando")

func terminarCocina():
	print("termino")
	Anim.play("Listo")
	ingredienteListo = true

func _entregarIngrediente(player):
	print("recogido")
	ingredienteListo = false
	Anim.play("Idle")
	player.recibirIngrediente(ingredienteARecoger)
	ingredienteARecoger = null
	

func _on_area_2d_body_entered(body): #COLISION
	
	if body.is_in_group("Players"): #Caso choca con un jugador
		#esta listo la cocina
		if ingredienteListo:
			print("recogeringrediente")
			print(ingredienteListo)
			_entregarIngrediente(body)
		#caso contrario
		if body.ingrediente == null:
			return
		#caso se entrega ingrediente 
		else:	
			
			body.entregaIngrediente(self)
			#if body.ingrediente.has_method('cocinarHorno') :  DEPRECADO
			#	print("ingrediente tiene metodo")
			#	body.ingrediente.cocinarHorno(self)
			
		
