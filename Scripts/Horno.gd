extends Node

@onready var Anim = $AnimationPlayer
var listaIngredientes = []

var ingredienteListo = false
var ingredienteARecoger = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func recibirIngrediente(ingrediente):
	if ingrediente.tipo != "Masa" and ingrediente.tipo != "TomatePicado":
		return
	listaIngredientes.append(ingrediente.tipo)
	ingrediente.queue_free()
	if (listaIngredientes.size() >= 2):
		_receta()
		cocinarIngrediente()
		listaIngredientes = []
	
func _receta():
	if listaIngredientes.count("Masa") == 1 and listaIngredientes.count("TomatePicado") == 1: #Se cocina una pizza
		ingredienteARecoger = preload("res://pan_horneado.tscn").instantiate()
	if listaIngredientes.count("TomatePicado") == 2: #Se cocina la sopa
		ingredienteARecoger = preload("res://pan_horneado.tscn").instantiate()
	if listaIngredientes.count("Masa") == 2: #Se cocina Bagguete
		ingredienteARecoger = preload("res://pan_horneado.tscn").instantiate()

func cocinarIngrediente():
	print("cocinando")
	Anim.play("Cocinando")

func terminarCocina():
	print("termino")
	Anim.play("Listo")
	ingredienteListo = true

func _entregarIngrediente(player):
	print("ingrediente entregado")
	ingredienteListo = false
	Anim.play("Idle")
	player.recibirIngrediente(ingredienteARecoger)
	ingredienteARecoger = null
	

func _on_area_2d_body_entered(body): #COLISION

	if body.is_in_group("Players"): #Caso choca con un jugador
		#esta listo la cocina
		if ingredienteListo:
			print("recogiendo ingrediente")
			_entregarIngrediente(body)
		#caso contrario
		if body.ingrediente == null:
			return
		#caso se entrega ingrediente 
		else:	
			print("entregando ingrediente")
			body.entregaIngrediente(self)
			#if body.ingrediente.has_method('cocinarHorno') :  DEPRECADO
			#	print("ingrediente tiene metodo")
			#	body.ingrediente.cocinarHorno(self)
			
		
