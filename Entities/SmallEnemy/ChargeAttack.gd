extends Node3D

signal attack_hit(body: CharacterBody3D)

var is_attacking = false

func set_target(node: Node3D):
	$LaserRaycast.target = node

func charge():
	if is_attacking:
		return false
	$LaserRaycast.start_tracking()
	is_attacking = true
	return true

func fire():
	if not is_attacking:
		return false
	$LaserRaycast.fire()
	check_hit()
	is_attacking = false
	return true

func check_hit():
	var body = $LaserRaycast.get_collider()
	if body != null and not body.is_ancestor_of(self):
		attack_hit.emit(body)

func _on_fire_animation_animation_looped():
	is_attacking = false
	$FireAnimation.stop()
