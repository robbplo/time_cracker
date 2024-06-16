extends CharacterBody2D

@export var fps: float = 18.0
@export var charge_frames: int = 11

signal attack_charge
signal attack_fire
signal attack_end
signal attack_hit(body: CharacterBody2D)


var is_attacking = false

func start(target: Vector2):
	charge(target)
	var delay = GlobalTimer.sixteenth_note_duration * 6 / 1000.0
	var anim = $"../AnimatedSprite".animation
	$"../AnimatedSprite".sprite_frames.set_animation_speed(anim, 1.0 / (delay / charge_frames))
	$"../AnimatedSprite".play()
	await get_tree().create_timer(delay).timeout
	fire()
	return true

func charge(target: Vector2):
	if is_attacking:
		return false
	attack_charge.emit()
	self.look_at(target)
	is_attacking = true

func fire():
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

