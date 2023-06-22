extends Node

@onready var Anim = $AnimationPlayer
var listaIngredientes = []

var ingredienteListo = false
var ingredienteARecoger = null

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("ProgressBar").visible= false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#esta funcion recibe un ingrediente y lo coloca en la lista de ingredientes del refrigerador
func recibirIngrediente(ingrediente):
	#si no es alguno de los ingredientes que admite el horno entonces no hace nada
	if ingrediente.tipo != "Leche" and ingrediente.tipo != "TomatePicado" and ingrediente.tipo != "Masa": 
		return
	#se agrega a la lista de ingredientes que estan dentro del horno
	listaIngredientes.append(ingrediente.tipo)
	print("recibido: " + ingrediente.tipo)
	ingrediente.queue_free() #se destruye el objeto del ingrediente ya que no es necesario ya
	print(listaIngredientes)
	if (listaIngredientes.size() >= 2): #si hay mas de 2 ingredientes entonces empieza a cocinar
		_receta() #se crea el resultado a partir de las recetas
		print(ingredienteARecoger)
		if ingredienteARecoger == null: #en caso se equivoco al colocar los ingredientes no se cocina nada
			return
			
		print(ingredienteARecoger)
		cocinarIngrediente() #se empieza a cocinar
		listaIngredientes = [] #la lista de ingredientes se resetea
	
func _receta():
	if listaIngredientes.count("Leche") == 1 and listaIngredientes.count("Masa") == 1: #Se cocina una masa pastelera
		ingredienteARecoger = preload("res://masa_pastelera.tscn").instantiate()
		return
	if listaIngredientes.count("Leche") == 1 and listaIngredientes.count("TomatePicado") == 1: #Se cocina la sopa
		ingredienteARecoger = preload("res://jalea.tscn").instantiate()
		return
	if listaIngredientes.count("Leche") == 2: #Se cocina un yogurt
		ingredienteARecoger = preload("res://yoghurt.tscn").instantiate()
		return

func cocinarIngrediente():
	print("empezo")
	Anim.play("Cocinando")

func terminarCocina():
	print("termino")
	Anim.play("Listo")
	ingredienteListo = true
	_agregarHUD()

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
	
func _agregarHUD():
	get_node("Panel").add_child(ingredienteARecoger)
	get_node("Panel").visible = true
	ingredienteARecoger.position = Vector2(get_node("Panel").size.x/2,get_node("Panel").size.y/2)
	ingredienteARecoger.scale.x = 2*ingredienteARecoger.scale.x
	ingredienteARecoger.scale.y = 2*ingredienteARecoger.scale.y
	ingredienteARecoger.get_node("Area2D").set_process(false)

func _quitarHUD():
	get_node("Panel").remove_child(ingredienteARecoger)
	ingredienteARecoger.get_node("Area2D").set_process(true)
	get_node("Panel").visible = false
	ingredienteARecoger.position = Vector2(0,0)
	ingredienteARecoger.scale.x = 0.5*ingredienteARecoger.scale.x
	ingredienteARecoger.scale.y = 0.5*ingredienteARecoger.scale.y


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
			
