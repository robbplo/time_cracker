extends Label

func _ready():
	text = "4th:"
	GlobalTimer.quarter_note.connect(func(x): text = " 4th: %s" % x)
