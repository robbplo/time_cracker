class_name TimedNode2D
extends Node2D

var cursor = 0
var actions = []

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("TimedNodes")

func beat():
	if actions.size() > cursor:
		actions[cursor].call()
		cursor = (cursor + 1) % actions.size()
	
func set_actions(value): 
	self.actions = value 
	
