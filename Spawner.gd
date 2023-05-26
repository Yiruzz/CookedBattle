extends Node2D
var ingredienteListo = true
var ingrediente = null
var rng = RandomNumberGenerator.new()
var tdelta = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_crearIngrediente()

func _crearIngrediente():
	var n = rng.randi_range(1, 4)
	self.get_node("Sprite2D1").visible = false
	self.get_node("Sprite2D2").visible = false
	self.get_node("Sprite2D3").visible = false
	self.get_node("Sprite2D4").visible = false
	
	if n == 1:
		ingrediente = preload("res://pan.tscn").instantiate()
		self.get_node("Sprite2D1").visible = true
	if n == 2:
		self.get_node("Sprite2D2").visible = true
		ingrediente = preload("res://leche.tscn").instantiate()
	if n == 3:
		self.get_node("Sprite2D3").visible = true
		ingrediente = preload("res://apio.tscn").instantiate()
	if n == 4:
		self.get_node("Sprite2D4").visible = true
		ingrediente = preload("res://tomate.tscn").instantiate()
	ingredienteListo = true
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tdelta = tdelta + delta
	if tdelta > 10 and ingredienteListo == false:
		_crearIngrediente()
		




func _on_area_2d_body_entered(body):
	if body.is_in_group("Players"):
		if ingredienteListo:
			print(ingrediente.tipo)
			if body.ingrediente != null:
				body.ingrediente.queue_free()
			body.recibirIngrediente(ingrediente)
			ingredienteListo = false
			self.get_node("Sprite2D1").visible = false
			self.get_node("Sprite2D2").visible = false
			self.get_node("Sprite2D3").visible = false
			self.get_node("Sprite2D4").visible = false
			tdelta = 0
