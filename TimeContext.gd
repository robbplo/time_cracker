extends Node2D

@export var bpm = 125
@export var running = false
var beat_time = 60.0 / bpm

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = beat_time
	$Timer.start()
	running = true

func beat():
	get_tree().call_group("TimedNodes", "beat")
	
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
	beat()

func get_timer():
	return $Timer
