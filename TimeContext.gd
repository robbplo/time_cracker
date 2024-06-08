extends Node2D

@export var bpm = 80
@export var running = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = 60.0 / bpm
	$Timer.start()

func beat():
	get_tree().call_group("TimedNodes", "beat")

func _on_timer_timeout():
	beat()

func get_timer():
	return $Timer
