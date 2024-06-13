extends Label

func _ready():
	text = "16th: ()"
	GlobalTimer.sixteenth_note.connect(func(x): text = " 16th: %s (%s)" % [x, (x / 4)])

