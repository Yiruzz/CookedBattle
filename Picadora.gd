extends Node

@onready var Anim = $AnimationPlayer
@onready var audio = $Audio
var listaIngredientes = []
var listaIngredientesAceptados = ["Apio","Tomate"]
var jugadorPicando = null
var ingredienteListo = false
var ingredienteARecoger = null
var porcentajeDePicado = 0
@onready var progressbar = null



# Called when the node enters the scene tree for the first time.
func _ready():
	progressbar = self.get_node("ProgressBar")
	progressbar.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func recibirIngrediente(ingrediente):			
	#se agrega a la lista de ingredientes que estan dentro del horno
	listaIngredientes.append(ingrediente)
	if (listaIngredientes.size() >= 1): #si hay mas de 1 ingredientes entonces empieza a cocinar
		if(listaIngredientes.size() >=2):
			listaIngredientes.pop_front().queue_free()
		_receta() #se crea el resultado a partir de las recetas
		if ingredienteARecoger == null: #en caso se equivoco al colocar los ingredientes no se cocina nada
			return
		print(ingredienteARecoger)
		cocinarIngrediente() #se empieza a cocinar
		_agregarHUD(ingrediente)
		return

	
func _liberarIngredientes():
	while !listaIngredientes.is_empty():
		listaIngredientes.pop_back().queue_free()
	listaIngredientes = [] #la lista de ingredientes se resetea
	
func _picar():
	if ingredienteARecoger == null:
		return
	print("picando")
	audio.play()
	porcentajeDePicado += 10
	progressbar.value = porcentajeDePicado
	if porcentajeDePicado >= 100:
		terminarCocina()
	
func _receta():
	var listaTiposIngredientes = []
	for item in listaIngredientes:	#NO PREGUNTEN PORQUE HISE ESTA INEFICIENCIA Y DOLOR DE TENER 2 LISTAS
		#DE INGREDIENTES, CUESTIONENSE MEJOR PORQUE SI DIOS ES TAN BENEVOLENTE ME TIENE EN ESTA SITUACION
		listaTiposIngredientes.append(item.tipo)

	if listaTiposIngredientes.count("Apio") == 1: #Se cocina un apio afilado
		ingredienteARecoger = preload("res://apio_afilado.tscn").instantiate()
		return
	if listaTiposIngredientes.count("Tomate") == 1: #Se cocina un tomate picado
		ingredienteARecoger = preload("res://tomate_picado.tscn").instantiate()
		return
	_ingredienteEquivocadoColocado()
		
func _ingredienteEquivocadoColocado():
	var ultimoIngrediente = listaIngredientes.pop_back()
	listaIngredientes = []
	listaIngredientes.append(ultimoIngrediente)
	ingredienteARecoger = null
	_agregarHUD(ultimoIngrediente)


func _agregarHUD(ingrediente):
	ingrediente.get_node("Sprite2D").visible = true
	ingrediente.visible = true
	get_node("Panel").call_deferred("add_child", ingrediente)
	get_node("Panel").visible = true
	ingrediente.position = Vector2(get_node("Panel").size.x/2,get_node("Panel").size.y/2)
	ingrediente.scale.x = 25/10*ingrediente.scale.x
	ingrediente.scale.y = 25/10*ingrediente.scale.y
	ingrediente.get_node("Area2D").set_process(false)
	
func _quitarHUD():
	var ingrediente = get_node("Panel").get_children()[0]
	get_node("Panel").remove_child(ingrediente)
	ingrediente.get_node("Area2D").set_process(true)
	get_node("Panel").visible = false
	ingrediente.position = Vector2(0,0)
	ingrediente.scale.x = 10/25*ingrediente.scale.x
	ingrediente.scale.y = 10/25*ingrediente.scale.y

		
func cocinarIngrediente():
	print("empezo")
	porcentajeDePicado = 0
	progressbar.visible = true
	progressbar.value = 0 
	

func terminarCocina():
	print("termino")
	_quitarHUD()
	_liberarIngredientes()
	Anim.play("Listo")
	ingredienteListo = true
	porcentajeDePicado = 0
	progressbar.visible = false
	_entregarIngrediente(jugadorPicando)
	

func _entregarIngrediente(player):
	if !player.armado or ingredienteARecoger.tipo != "TomatePicado":
		
		print("ingrediente entregado")
		ingredienteListo = false
		Anim.play("Idle")
		ingredienteARecoger.add_to_group(player.get_groups()[0]) #mira si lees esto y no entiendes esta linea de codigo
																#es porque son las 4 am y literal hise todas las colisiones
																#se detecten por grupos si el arma que recibe no detecta
																#que es por ejempplo parte del player 1, le pegaran sus
																#propios wates 
		player.recibirIngrediente(ingredienteARecoger)
		ingredienteARecoger = null
		

func _on_area_2d_body_entered(body): #COLISION
	
	if body.is_in_group("Players"): #Caso choca con un jugador
		body.picar.connect(_picar)
		jugadorPicando = body
		
		#caso jugador no tiene ingrediente equipado
		if body.ingrediente == null:
			return
		#caso se entrega ingrediente 
		else:	
			if !body.armado:
				body.entregaIngrediente(self)
			#if body.ingrediente.has_method('cocinarHorno') :  DEPRECADO
			#	print("ingrediente tiene metodo")
			#	body.ingrediente.cocinarHorno(self)
			
		


func _on_area_2d_body_exited(body):
	if body.is_in_group("Players"): #Caso choca con un jugador
		body.picar.disconnect(_picar)
