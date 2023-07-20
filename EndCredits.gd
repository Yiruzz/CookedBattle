extends Node2D

const base_speed = 100
var contador = 0
@onready var music = $AudioStreamPlayer2D

@onready var godot = $godotSprite
var gx = 419
var gy = 4850

@onready var logo = $Logo
var logox = 420
var logoy = 575

@onready var label = $Label
var xpos = 10
var ypos = 500




# Called when the node enters the scene tree for the first time.
func _ready():
	label.set_position(Vector2(xpos, ypos))
	logo.set_position(Vector2(logox, logoy))
	godot.set_position(Vector2(gx, gy))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ypos > -4030:
		ypos -= base_speed * delta
		logoy -= base_speed * delta
		gy -= base_speed * delta
		label.set_position(Vector2(xpos, ypos))
		logo.set_position(Vector2(logox, logoy))
		godot.set_position(Vector2(gx, gy))
	else:
		music.volume_db -= 0.02
		contador += 0.02
		if contador >= 45:
			get_tree().change_scene_to_file("res://beginScreen.tscn")
