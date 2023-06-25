extends Control

@onready var play = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	play.pressed.connect(_on_play_pressed)
	play.grab_focus()

func _on_play_pressed():
	$"../../AudioStreamPlayer".play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")
