class_name AreaTargetingStrategy extends TargetingStrategy

func get_orientation() -> Vector3:
	return get_origin().direction_to(get_target())

func get_target() -> Vector3:
	return _get_mouse_position()

func get_origin() -> Vector3:
	return PlayerStats.get_player().global_position

func _get_mouse_position() -> Vector3:
	var player := PlayerStats.get_player()
	var viewport := player.get_viewport()
	var mouse_pos := viewport.get_mouse_position()
	var camera := viewport.get_camera_3d()
	var origin := camera.project_ray_origin(mouse_pos)
	var direction := camera.project_ray_normal(mouse_pos)
	var ray_length := camera.far
	var ray_end := origin + direction * ray_length
	var space_state := player.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin, ray_end)
	var result := space_state.intersect_ray(query)
	return result["position"]

