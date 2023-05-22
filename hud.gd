extends MarginContainer

@onready var progress_bar = $ProgressBar
@onready var player = null
@export var nombrePlayer = "player"


func _ready():
	player = self.get_parent().get_node(nombrePlayer)
	player.hud.connect(_set_health)

func _set_health():
	progress_bar.value = player.Vida
