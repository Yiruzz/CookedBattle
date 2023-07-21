extends MarginContainer

@onready var play_again = %Play_Again
@onready var main_menu = %Main_Menu
@onready var player = null
@export var nombrePlayer = "player"


# Called when the node enters the scene tree for the first time.
func _ready():
	player = self.get_parent().get_node(nombrePlayer)
	player.winscreen.connect(_display)
	hide()
	
	get_node("PanelContainer/MarginContainer/VBoxContainer/WinTitle").text = nombrePlayer + " wins"
	
	

func _display():
	play_again.pressed.connect(_on_playAgain_pressed)
	main_menu.pressed.connect(_on_main_menu_pressed)
	show()
	%Play_Again.grab_focus()
	get_tree().paused = true
	$AudioStreamPlayer3.play()
	
	
func _on_playAgain_pressed():
	$AudioStreamPlayer.play()
	SceneTransition.change_scene_to_file("res://scenes/main.tscn")
	await get_tree().create_timer(0.1).timeout
	hide()

func _on_main_menu_pressed():
	$AudioStreamPlayer.play()
	SceneTransition.change_scene_to_file("res://beginScreen.tscn")

func _on_play_again_focus_exited():
	$AudioStreamPlayer2.play()
	
func _on_main_menu_focus_exited():
	$AudioStreamPlayer2.play()
