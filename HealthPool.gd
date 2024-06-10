extends Node2D
class_name HealthPool

signal health_changed(amount)
signal die

var dead = false
@export var health = -INF
@export var max_health = -INF

func _ready():
	update_bar()

func subtract(amount):
	assert(health > 0 && !dead, "subtract health below zero")
	if dead:
		return
	var new_health = max(0, health - amount)
	health = new_health
	update_bar()
	if new_health == 0:
		dead = true
		die.emit()
		return
	health_changed.emit(-amount)
	
func update_bar():
	$"ProgressBar".value = health / max_health * 100
