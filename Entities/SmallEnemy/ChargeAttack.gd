extends CharacterBody2D

@export var fps: float = 18.0
@export var charge_frames: int = 11

signal attack_charge
signal attack_fire
signal attack_end
signal attack_hit(body: CharacterBody2D)


var is_attacking = false

func start(target: Vector2):
	start_attack(target)
	var delay = GlobalTimer.quarter_note_duration / 1000.0
	var anim = $"../AnimatedSprite".animation
	$"../AnimatedSprite".sprite_frames.set_animation_speed(anim, 1.0/ (delay / charge_frames))
	await get_tree().create_timer(delay).timeout
	check_hit()
	return true

func start_attack(target: Vector2):
	if is_attacking:
		return false
	attack_charge.emit()
	self.look_at(target)
	is_attacking = true
	$"../AnimatedSprite".play()

func check_hit():
	if not is_attacking:
		return false
	$FireAnimation.show()
	$FireAnimation.play()
	for body in $Area2D.get_overlapping_bodies():
		if not body.is_ancestor_of(self):
			attack_hit.emit(body)

func _on_fire_animation_animation_looped():
	attack_end.emit()
	is_attacking = false
	$FireAnimation.hide()
	$FireAnimation.stop()

