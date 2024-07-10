class_name TimedAnimation
extends AnimationPlayer
## AnimationPlayer that follows the pulse of the global timer
##
## In the animations, each second corresponds to a bar in the song
## The snapping value corresponds to musical subdivisions.
## Set snapping to 16 for 16th note subdivisions, to 8 for 8th notes, and so on.

## The name of the animation that will be played
@export var animation: String = ""

const ANIM_FRAME_TIME = (1.0/4)

func _ready():
	speed_scale = 1 / (GlobalTimer.quarter_note_duration * 4)
	GlobalTimer.started.connect(start)
	if GlobalTimer.running:
		start_in_progress()

func start():
	play(animation)

func start_in_progress():
	var note_index = await GlobalTimer.quarter_note
	play(animation)
	seek(note_index * ANIM_FRAME_TIME)
