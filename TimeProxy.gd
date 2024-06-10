class_name TimeProxy
extends Node2D

signal beat(current_beat: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_context().beat.connect(_on_beat)

func get_context() -> TimeContext:
	var context = find_parent("TimeContext")
	assert(is_instance_valid(context), "timed node spawned outside of time context")
	return context

func _on_beat(current_beat):
	beat.emit(current_beat)
