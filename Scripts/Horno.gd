extends StaticBody2D

@onready var Anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func cocinarIngrediente():
	pass

func entrgearIngrediente():
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player1"):
		body.entregaIngrediente(self)
	
