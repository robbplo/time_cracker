class_name Pickup
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	monitoring = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	area_entered.connect(_pickupItem)
	
func _pickupItem():
	pass
