extends Node


var porcentajeDePicado = 0
@onready var progressbar = null
var player = null
# Called when the node enters the scene tree for the first time.
func _ready():
	porcentajeDePicado = 0
	progressbar = self.get_node("ProgressBar")
	progressbar.value = porcentajeDePicado
	progressbar.visible = false
	pass # Replace with function body.




func _lavarse():
	print("lavandose")
	porcentajeDePicado += 34
	progressbar.value = porcentajeDePicado
	if porcentajeDePicado >= 100:
		_destun()
	


	

func _destun():
	player.destun()
	print("termino")
	porcentajeDePicado = 0
	progressbar.value = porcentajeDePicado
	progressbar.visible = false
	





func _on_area_2d_body_entered(body):
	if body.is_in_group("Players"): #Caso choca con un jugador")
		progressbar.visible = true
		body.lavarse.connect(_lavarse)
		player = body



func _on_area_2d_body_exited(body):
	if body.is_in_group("Players"): #Caso choca con un jugador")
		body.lavarse.disconnect(_lavarse)
		player = null
		progressbar.visible = false
