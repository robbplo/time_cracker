extends Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Converts the time left of the timer to format 00:00
func _format_seconds() -> String:
	var minutes := time_left / 60
	var seconds := fmod(time_left, 60)
	return "%02d:%02d" % [minutes, seconds]
