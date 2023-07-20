extends MarginContainer

@onready var play = %Play
@onready var credits = %Credits
@onready var exit = %Exit


# Called when the node enters the scene tree for the first time.
func _ready():
	play.pressed.connect(_on_play_pressed)
	credits.pressed.connect(_on_credits_pressed)
	exit.pressed.connect(_on_exit_pressed)
	play.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_tree().paused = false

func _on_play_pressed():
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.25).timeout
	SceneTransition.change_scene_to_file("res://scenes/load_menu.tscn")

func _on_credits_pressed():
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.25).timeout
	SceneTransition.change_scene_to_file("res://EndCredits.tscn")


func _on_exit_pressed():
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()
	
func _on_credits_focus_exited():
	$AudioStreamPlayer2.play()

func _on_play_focus_exited():
	$AudioStreamPlayer2.play()
	
func _on_exit_focus_exited():
	$AudioStreamPlayer2.play()
