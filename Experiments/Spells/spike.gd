extends Spell
class_name Spike

const HITBOX_ACTIVE_TIME = .3

var force_multiplier := 150.0
var damage := 2.5

func _ready() -> void:
	$Area2D.monitoring = false
	scale.x = 0.0

func cast():
	look_at(get_global_mouse_position())
	$Area2D.monitoring = true
	var t = create_tween()
	t.set_ease(Tween.EASE_OUT)
	t.set_trans(Tween.TRANS_CUBIC)
	t.tween_property(self, "scale:x", 1.1, .1)
	t.set_ease(Tween.EASE_IN)
	t.set_trans(Tween.TRANS_LINEAR)
	t.tween_property(self, "scale:x", 0.0, .2)
	await get_tree().create_timer(HITBOX_ACTIVE_TIME).timeout
	scale.x = 0.0
	$Area2D.monitoring = false

func _on_area_2d_body_entered(body:Node2D) -> void:
	if body is Character:
		body.velocity += (Vector2.from_angle(rotation) * force_multiplier)
		body.take_damage(damage)

