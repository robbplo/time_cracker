class_name TimedNode2D
extends Node2D

var cursor = 0
var actions = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func beat():
	if actions.size() > cursor:
		actions[cursor].call()
		cursor = (cursor + 1) % actions.size()
	
func set_actions(actions): 
	self.actions = actions 
	
