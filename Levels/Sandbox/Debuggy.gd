extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# GlobalTimer.quarter_note.connect(check)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func check(_a):
	GlobalTimer.is_on_time()
