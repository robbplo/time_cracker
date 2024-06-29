extends Pickup

@export var playing_kick:bool

func _pickupItem():
	$"../..".playing_kick = true
