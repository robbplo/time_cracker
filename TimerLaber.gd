extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#deploys the func in the text of the label
	text = _format_seconds(120)

#declares the numbers and returns the numbers as a string
func _format_seconds(time : float) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	return "%02d:%02d" % [minutes, seconds]
