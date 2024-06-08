extends CharacterBody2D

var is_attacking = false

func start(target: Vector2):
	self.look_at(target)
	is_attacking = true
	show()
	$Area2D.monitoring = true
	$Animation.play()

func _on_animation_animation_looped():
	is_attacking = false
	hide()
	$Area2D.monitoring = false
	$Animation.stop()


func _on_area_2d_body_entered(body):
	if is_attacking:
		body.get_parent().queue_free()
	print(body)
	pass # Replace with function body.
