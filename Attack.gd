extends CharacterBody2D

var is_attacking = false

## Returns whether the attack was started or not
func start(target: Vector2):
	if is_attacking:
		return false
	self.look_at(target)
	is_attacking = true
	show()
	$Area2D.monitoring = true
	$Animation.play()
	return true

func _on_animation_animation_looped():
	is_attacking = false
	hide()
	$Area2D.monitoring = false
	$Animation.stop()
