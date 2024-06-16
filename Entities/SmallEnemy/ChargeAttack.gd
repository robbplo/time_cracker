extends CharacterBody2D

@export var fps: float = 18.0
@export var charge_frames: int = 11

signal attack_charge
signal attack_fire
signal attack_end
signal attack_hit(body: CharacterBody2D)


var is_attacking = false

func _ready():
	$Laser.hide()

func charge(target: Vector2):
	if is_attacking:
		return false
	$Laser.show()
	attack_charge.emit()
	self.look_at(target)
	is_attacking = true

func fire():
	if not is_attacking:
		return false
	var laser_height = 5
	$Laser.size.y = laser_height
	$Laser.position.y = laser_height / 2.0
	var tween = create_tween()
	tween.tween_property($Laser, "size.y", 1, .1)
	tween.tween_property($Laser, "position.y", 0, .1)

	$FireAnimation.play()
	$Laser.hide()
	check_hit()

func check_hit():
	for body in $Area2D.get_overlapping_bodies():
		if not body.is_ancestor_of(self):
			attack_hit.emit(body)

func _on_fire_animation_animation_looped():
	attack_end.emit()
	is_attacking = false
	$FireAnimation.stop()

