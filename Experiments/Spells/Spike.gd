extends Area2D
class_name Spike

var direction: Vector2
var force_multiplier := 100.0

func cast():
	look_at(get_global_mouse_position())
	# wait for the next physics frame to ensure collisions were updated
	await get_tree().physics_frame
	await get_tree().physics_frame
	# all bodies should be enemies
	var enemies = get_overlapping_bodies()
	print(enemies)

	for enemy in enemies:
		enemy.velocity += (Vector2.from_angle(rotation) * force_multiplier)



