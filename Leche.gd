extends Node2D
var tipo = "Leche"


func changePlayerTexture():
	self.visible = false
	return preload("res://assets/characters/ChefV1_grabbing_milk.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
