extends Node
var tipo = "Masa" #no pregunten y no juzgen xfavor
func cocinarHorno(horno):
	horno.ingredienteARecoger = preload("res://pan_horneado.tscn").instantiate()
	horno.cocinarIngrediente()
	self.queue_free()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
