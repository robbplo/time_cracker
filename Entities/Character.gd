extends CharacterBody3D
class_name Character

signal health_changed(new: float, previous: float)
signal died

# Settings
@export var max_health: float

# State variables
@onready var health: float
var is_alive: bool = true
var is_invulnerable = false

func _ready() -> void:
	set_health(max_health)

# TODO: create an Attack class which carries damage amount
func take_damage(amount: float):
	if not is_alive || is_invulnerable || is_queued_for_deletion():
		return

	set_health(health - amount)
	if health <= 0.0 and is_alive:
		is_alive = false
		died.emit()
		die()
		return

func set_health(amount: float):
	var previous = health
	health = max(0.0, amount)
	health_changed.emit(health, previous)

func die():
	queue_free()
