extends Node

@onready var Anim = $AnimationPlayer
var listaIngredientes = []
var listaIngredientesAceptados = ["Leche","TomatePicado"]
var ingredienteListo = false
var ingredienteARecoger = null
var equivocado = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("ProgressBar").visible= false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#esta funcion recibe un ingrediente y lo coloca en la lista de ingredientes del refrigerador
func recibirIngrediente(ingrediente):
	listaIngredientes.append(ingrediente)
	if (listaIngredientes.size() >= 2): #si hay mas de 2 ingredientes entonces empieza a cocinar
		_receta() #se crea el resultado a partir de las recetas
		if ingredienteARecoger == null: #en caso se equivoco al colocar los ingredientes no se cocina nada
			return
		print(ingredienteARecoger)
		cocinarIngrediente() #se empieza a cocinar
		_liberarIngredientes()
		return
	print(listaIngredientes)
	_agregarHUD(ingrediente)
	
	
func _liberarIngredientes():
	while !listaIngredientes.is_empty():
		listaIngredientes.pop_back().queue_free()
	listaIngredientes = [] #la lista de ingredientes se resetea


func _receta():
	var listaTiposIngredientes = []
	for item in listaIngredientes:	#NO PREGUNTEN PORQUE HISE ESTA INEFICIENCIA Y DOLOR DE TENER 2 LISTAS
		#DE INGREDIENTES, CUESTIONENSE MEJOR PORQUE SI DIOS ES TAN BENEVOLENTE ME TIENE EN ESTA SITUACION
		listaTiposIngredientes.append(item.tipo)
		
	if listaTiposIngredientes.count("Leche") == 1 and listaTiposIngredientes.count("TomatePicado") == 1: #Se cocina la sopa
		ingredienteARecoger = preload("res://jalea.tscn").instantiate()
		return
	if listaTiposIngredientes.count("Leche") == 2: #Se cocina un yogurt
		ingredienteARecoger = preload("res://mantequilla.tscn").instantiate()
		return
	_ingredienteEquivocadoColocado()


func _ingredienteEquivocadoColocado():
	var ultimoIngrediente = listaIngredientes.pop_back()
	listaIngredientes = []
	listaIngredientes.append(ultimoIngrediente)
	ingredienteARecoger = null
	_agregarHUD(ultimoIngrediente)
	
	

func cocinarIngrediente():
	print("empezo")
	_agregarHUD(ingredienteARecoger)
	Anim.play("Cocinando")

func terminarCocina():
	print("termino")
	Anim.play("Listo")
	ingredienteListo = true


func _entregarIngrediente(player):
	print("ingrediente entregado")
	ingredienteListo = false
	Anim.play("Idle")
	ingredienteARecoger.add_to_group(player.get_groups()[0]) #mira si lees esto y no entiendes esta linea de codigo
															#es porque son las 4 am y literal hise todas las colisiones
															#se detecten por grupos si el arma que recibe no detecta
															#que es por ejempplo parte del player 1, le pegaran sus
															#propios wates 
	_quitarHUD()
	player.recibirIngrediente(ingredienteARecoger)
	ingredienteARecoger = null
	
func _agregarHUD(ingrediente):
	ingrediente.get_node("Sprite2D").visible = true
	ingrediente.visible = true
	get_node("Panel").call_deferred("add_child", ingrediente)
	get_node("Panel").visible = true
	ingrediente.position = Vector2(get_node("Panel").size.x/2,get_node("Panel").size.y/2)
	ingrediente.scale.x = 30/10*ingrediente.scale.x
	ingrediente.scale.y = 30/10*ingrediente.scale.y
	ingrediente.get_node("Area2D").set_process(false)
	
func _quitarHUD():
	var ingrediente = get_node("Panel").get_children()[0]
	get_node("Panel").remove_child(ingrediente)
	ingrediente.get_node("Area2D").set_process(true)
	get_node("Panel").visible = false
	ingrediente.position = Vector2(0,0)
	ingrediente.scale.x = 10/30*ingrediente.scale.x
	ingrediente.scale.y = 10/30*ingrediente.scale.y

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
			
			body.entregaIngrediente(self)
			#if body.ingrediente.has_method('cocinarHorno') :  DEPRECADO
			#	print("ingrediente tiene metodo")
			#	body.ingrediente.cocinarHorno(self)
			
