extends Node2D
class_name TimeContext

signal beat(current_beat: int)

@export var bpm = 112
@export var running = false
var current_beat = 0
var subdivisions = 16
var meter = 4
var beat_time = 60.0 / bpm / (subdivisions / meter)

# move cursor to context
# add subdivisons variable
# create signal for beat

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = beat_time
	$Timer.start()
	running = true

func is_on_time(ms: int) -> bool:
	return distance_to_beat() * 1000 < ms

## Returns the 'distance' to the beat in seconds relative to the current timer.
## If it's .01s before or after the beat, returns .01
func distance_to_beat() -> float:
	var time_left = $Timer.time_left
	if time_left < (beat_time / 2.0):
		# second half of the beat, distance equals time_left
		return time_left
	else:
		# first half of the beat, distance is time since previous beat
		return abs(beat_time - time_left)

func _on_timer_timeout():
	beat.emit(current_beat)
	print(current_beat)
	current_beat += 1

func get_timer():
	return $Timer
