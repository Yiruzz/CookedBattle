extends Timer

var encendido = false
var s1 = true
var s2 = true
# Called when the node enters the scene tree for the first time.
func _ready():
	encendido = true
	get_tree().paused = true
	$"../AudioStreamPlayer".play()
	$"../Panel/TimeLeft".show()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if encendido:
		var labelTextdecimals = fmod($".".get_time_left(), 1)*100
		var labelTextSeconds = int($".".get_time_left())
		$"../Panel/TimeLeft".set_text("%2d" % [labelTextSeconds+1])
		if s1 and get_time_left()<=2:
			s1 = false
			$"../AudioStreamPlayer".play()
		elif s2 and get_time_left()<=1:
			s2 = false
			$"../AudioStreamPlayer".play()
			
	
func _on_timeout():
	if encendido:
		$"../AudioStreamPlayer2".play()
		$"../Panel".hide()
		encendido = false
		get_tree().paused = false
		
