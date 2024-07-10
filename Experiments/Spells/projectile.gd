extends Spell
class_name Projectile

const BULLET = preload("res://Experiments/Spells/bullet.tscn")
const HITBOX_ACTIVE_TIME = .3

var force_multiplier := 50.0
var damage := 1.0

func cast():
	var bullet = BULLET.instantiate()
	bullet.direction = global_position.direction_to(get_global_mouse_position()).normalized()
	bullet.global_position = global_position
	bullet.hit.connect(_on_bullet_hit)
	get_tree().root.add_child(bullet)

func _on_bullet_hit(body:Node2D) -> void:
	if body is Character:
		body.velocity += (Vector2.from_angle(rotation) * force_multiplier)
		body.take_damage(damage)

