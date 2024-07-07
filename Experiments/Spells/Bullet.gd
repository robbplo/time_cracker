extends StaticBody2D
class_name Bullet

signal hit(body)

var direction = Vector2.RIGHT
var lifetime = 3.0
var velocity = 900.0
var acceleration = 3.0

func _ready():
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	velocity += acceleration
	var collision = move_and_collide((direction * velocity) * delta)
	if collision and not is_queued_for_deletion():
		print(collision.get_collider())
		hit.emit(collision.get_collider())
		queue_free()

