extends Node
var tipo = "Masa"

func changePlayerTexture(jugador):
	self.visible = false
	if jugador.numJugador == 1:
		return preload("res://assets/characters/ChefV1_grabbing_dough.png")
	else:
		return preload("res://assets/characters/ChefV2_grabbing_dough.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
