extends Node2D
var tipo = "Apio"

func changePlayerTexture(numJugador):
	self.visible = false
	if numJugador == 1:
		return preload("res://assets/characters/ChefV1_grabbing_asparagus.png")
	else:
		return preload("res://assets/characters/ChefV2_grabbing_asparagus.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
