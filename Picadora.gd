extends Node

@onready var Anim = $AnimationPlayer
var listaIngredientes = []

var ingredienteListo = false
var ingredienteARecoger = null
var porcentajeDePicado = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func recibirIngrediente(ingrediente):			
	if ingrediente.tipo != "Apio" and ingrediente.tipo != "Tomate": 
		return
	#se agrega a la lista de ingredientes que estan dentro del horno
	listaIngredientes.append(ingrediente.tipo)
	ingrediente.queue_free() #se destruye el objeto del ingrediente ya que no es necesario ya
	if (listaIngredientes.size() >= 1): #si hay mas de 2 ingredientes entonces empieza a cocinar
		_receta() #se crea el resultado a partir de las recetas
		if ingredienteARecoger == null: #en caso se equivoco al colocar los ingredientes no se cocina nada
			return
		cocinarIngrediente() #se empieza a cocinar
		listaIngredientes = [] #la lista de ingredientes se resetea
	
func _picar():
	print("picando")
	porcentajeDePicado += 10
	if porcentajeDePicado >= 100:
		terminarCocina()
	
func _receta():
	if listaIngredientes.count("Apio") == 1: #Se cocina un apio afilado
		ingredienteARecoger = preload("res://apio_afilado.tscn").instantiate()
		return
	if listaIngredientes.count("Tomate") == 1: #Se cocina un tomate picado
		ingredienteARecoger = preload("res://tomate_picado.tscn").instantiate()
		return
	else:
		ingredienteARecoger = null
func cocinarIngrediente():
	print("empezo")
	porcentajeDePicado = 0
	

func terminarCocina():
	print("termino")
	Anim.play("Listo")
	ingredienteListo = true
	porcentajeDePicado = 0

func _entregarIngrediente(player):
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
		#esta listo la cocina
		if ingredienteListo:
			
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
			
		


func _on_area_2d_body_exited(body):
	if body.is_in_group("Players"): #Caso choca con un jugador
		body.picar.disconnect(_picar)
