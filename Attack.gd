extends CharacterBody2D

signal attack_start
signal attack_end
signal attack_hit

var is_attacking = false

func start(target: Vector2):
	if is_attacking:
		return false
	emit_signal("attack_start")
	self.look_at(target)
	is_attacking = true
	$Animation.show()
	$Animation.play()
	
	for body in $Area2D.get_overlapping_bodies():
		if not body.is_ancestor_of(self):
			emit_signal("attack_hit", body)
	
	return true

func _on_animation_animation_looped():
	emit_signal("attack_end")
	is_attacking = false
	$Animation.hide()
	$Animation.stop()

