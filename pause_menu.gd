extends MarginContainer

@onready var resume = %Resume
@onready var main_menu = %Main_Menu

# Called when the node enters the scene tree for the first time.
func _ready():
	resume.pressed.connect(_on_resume_pressed)
	main_menu.pressed.connect(_on_main_menu_pressed)
	hide()

func _input(event):
	if event.is_action_pressed("pause"):
		show()
		get_tree().paused = true
		%Resume.grab_focus()
	
	
func _on_resume_pressed():
	get_tree().paused = false
	hide()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://beginScreen.tscn")
	get_tree().paused = false
