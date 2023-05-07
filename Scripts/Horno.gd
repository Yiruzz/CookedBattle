extends Node

@onready var Anim = $AnimationPlayer

var recogerIngrediente = false
var ingredienteARecoger = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func cocinarIngrediente():
	print("empezo")
	Anim.play("Cocinando")

func terminarCocina():
	print("termino")
	Anim.play("Listo")
	recogerIngrediente = true

func _entregarIngrediente(player):
	print("recogido")
	recogerIngrediente = false
	Anim.play("Idle")
	player.recibirIngrediente(ingredienteARecoger)
	ingredienteARecoger = null
	

func _on_area_2d_body_entered(body):
	
	if body.is_in_group("Players"):
		if recogerIngrediente:
			print("recogeringrediente")
			print(recogerIngrediente)
			_entregarIngrediente(body)
			
		if body.ingrediente == null:
			return
		if recogerIngrediente:
			print("recogeringrediente")

		else:	
			if body.ingrediente.has_method('cocinarHorno') :
				print("ingrediente tiene metodo")
				body.ingrediente.cocinarHorno(self)
		
