extends CharacterBody2D

@export var fps: int = 18
@export var charge_frames: int = 11

signal attack_charge
signal attack_fire
signal attack_end
signal attack_hit(body: CharacterBody2D)


var is_attacking = false

func start(target: Vector2):
	start_attack(target)
	await get_tree().create_timer((1.0/fps) * charge_frames).timeout

	check_hit()
	return true

func start_attack(target: Vector2):
	if is_attacking:
		return false
	attack_charge.emit()
	self.look_at(target)
	is_attacking = true
	$"../AnimatedSprite".play()
	$"../AnimatedSprite/OrbAnimation".show()
	$"../AnimatedSprite/OrbAnimation".play()
	$"../AnimatedSprite/GlowAnimation".show()
	$"../AnimatedSprite/GlowAnimation".play()


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

