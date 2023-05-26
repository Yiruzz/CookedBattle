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
	print("hola")
	play_again.pressed.connect(_on_playAgain_pressed)
	main_menu.pressed.connect(_on_main_menu_pressed)
	show()
	get_tree().paused = true
	
	
func _on_playAgain_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	get_tree().paused = false
	hide()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://beginScreen.tscn")
	get_tree().paused = false
