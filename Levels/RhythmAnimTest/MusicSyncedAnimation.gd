extends AnimationPlayer

func _ready():
	GlobalTimer.started.connect(_on_global_timer_started)

func _on_global_timer_started():
	speed_scale = 1/(GlobalTimer.quarter_note_duration * 4)
	play("test_anim")

var prev_time = 0
func print_time():
	print("anim: ", GlobalTimer.distance_to_quarter_note())

