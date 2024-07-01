extends CharacterBody2D
#class_name Bullet

const SPEED = 300.0

var direction = Vector2.RIGHT
var lifetime = 3.0

func _ready():
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	var movement = (direction * SPEED) * delta
	move_and_collide(movement)
