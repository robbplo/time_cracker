extends Spell
class_name ForcePush

const HITBOX_ACTIVE_TIME = .3

var force_multiplier := 1500.0
var damage := .5

func _ready() -> void:
	$Area2D.monitoring = false
	$GPUParticles2D.emitting = false

func cast():
	look_at(get_global_mouse_position())
	$Area2D.monitoring = true
	var t = create_tween()
	$GPUParticles2D.emitting = true
	$GPUParticles2D.amount_ratio = 1.0
	$GPUParticles2D.process_material.initial_velocity_min = 1000.0
	$GPUParticles2D.process_material.initial_velocity_max = 1500.0
	t.tween_property($GPUParticles2D, "amount_ratio", 0.0, HITBOX_ACTIVE_TIME)
	t.parallel().tween_property($GPUParticles2D.process_material, "initial_velocity_min", 100.0, HITBOX_ACTIVE_TIME)
	t.parallel().tween_property($GPUParticles2D.process_material, "initial_velocity_max", 100.0, HITBOX_ACTIVE_TIME)
	await get_tree().create_timer(HITBOX_ACTIVE_TIME).timeout
	$GPUParticles2D.emitting = false
	$Area2D.monitoring = false

func _on_area_2d_body_entered(body:Node2D) -> void:
	if body is Character:
		body.velocity += (Vector2.from_angle(rotation) * force_multiplier)
		body.take_damage(damage)
