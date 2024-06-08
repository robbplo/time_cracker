extends Node2D

@export var bpm = 80
@export var running = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = 60.0 / bpm
	$Timer.start()
	print("timer ready")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func beat():
	for child in get_children():
		if child is TimedNode2D:
			child.beat()


func _on_timer_timeout():
	beat()
	
func get_timer():
	return $Timer
