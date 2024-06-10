extends CharacterBody2D

signal attack_start
signal attack_end
signal attack_hit(body: CharacterBody2D)

var is_attacking = false

func start(target: Vector2):
	start_attack(target)
	check_hit()
	
	return true

func start_attack(target: Vector2):
	if is_attacking:
		return false
	attack_start.emit()
	self.look_at(target)
	is_attacking = true
	$Animation.show()
	$Animation.play()

func check_hit():
	if not is_attacking:
		return false
	for body in $Area2D.get_overlapping_bodies():
		if not body.is_ancestor_of(self):
			attack_hit.emit(body)

func _on_animation_animation_looped():
	attack_end.emit()
	is_attacking = false
	$Animation.hide()
	$Animation.stop()

