extends Spell
class_name ForcePush

const HITBOX_ACTIVE_TIME = .3

var force_multiplier := 30.0
var damage := .5

const MAX_RANGE := 3.0

func _ready() -> void:
	$Area3D.monitoring = false
	$GPUParticles3D.emitting = false

func cast():
	look_at(get_mouse_position(), Vector3.UP)

	$Area3D.monitoring = true
	var t := create_tween().set_parallel()
	$GPUParticles3D.emitting = true
	$GPUParticles3D.amount_ratio = 1.0
	$GPUParticles3D.process_material.initial_velocity_min = 60.0
	$GPUParticles3D.process_material.initial_velocity_max = 90.0
	t.set_trans(Tween.TRANS_QUAD)
	t.set_ease(Tween.EASE_OUT)
	t.tween_property($GPUParticles3D, "amount_ratio", 0.0, HITBOX_ACTIVE_TIME)
	t.tween_property($GPUParticles3D.process_material, "initial_velocity_min", 2.0, HITBOX_ACTIVE_TIME)
	t.tween_property($GPUParticles3D.process_material, "initial_velocity_max", 3.0, HITBOX_ACTIVE_TIME)
	await get_tree().create_timer(HITBOX_ACTIVE_TIME).timeout
	$GPUParticles3D.emitting = false
	$Area3D.monitoring = false

func _on_area_3d_body_entered(body:Node3D) -> void:
	if body is Character:
		var distance = global_position.distance_to(body.global_position)
		var direction = global_position.direction_to(body.global_position)
		var closeness = MAX_RANGE / distance
		body.velocity += direction * force_multiplier * closeness
		body.take_damage(damage)

func get_mouse_position() -> Vector3:
	var viewport := get_viewport()
	var mouse_pos := viewport.get_mouse_position()
	var camera := viewport.get_camera_3d()
	var origin := camera.project_ray_origin(mouse_pos)
	var direction := camera.project_ray_normal(mouse_pos)
	var ray_length := camera.far
	var ray_end := origin + direction * ray_length
	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin, ray_end)
	var result := space_state.intersect_ray(query)
	return result["position"]
