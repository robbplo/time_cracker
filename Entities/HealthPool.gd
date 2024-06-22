extends Node2D
class_name HealthPool

signal health_changed(amount)
signal die

@export var max_health = 2
var health = max_health
var dead = false

func _ready():
	update_bar()

func subtract(amount):
	if dead || health <= 0:
		return
	var new_health = max(0, health - amount)
	health = new_health
	update_bar()
	if new_health <= 0 and not dead:
		dead = true
		die.emit()
		return
	health_changed.emit(-amount)

func update_bar():
	$"ProgressBar".value = health / max_health * 100
