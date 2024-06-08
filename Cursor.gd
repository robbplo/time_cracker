extends Sprite2D

func _physics_process(delta):
	self.look_at(get_global_mouse_position())
	#var distance = get_global_mouse_position().distance_to($"../Player".global_position)
	#if distance < 80:
		#self.translate
