extends MarginContainer

@onready var play = %Play
@onready var credits = %Credits
@onready var exit = %Exit
var modo = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	play.pressed.connect(_on_play_pressed)
	credits.pressed.connect(_on_credits_pressed)
	exit.pressed.connect(_on_exit_pressed)
	%Play.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_credits_pressed():
	pass


func _on_exit_pressed():
	get_tree().quit()
