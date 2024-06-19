extends CharacterBody2D

@export var fps: float = 18.0
@export var charge_frames: int = 11

signal attack_charge
signal attack_fire
signal attack_end
signal attack_hit(body: CharacterBody2D)


var is_attacking = false


func charge(target: Vector2):
	if is_attacking:
		return false
	attack_charge.emit()
	$LaserRaycast.look_at(target)
	$LaserRaycast/RayCast2D/Line2D.width = 2
	is_attacking = true

func fire():
	if not is_attacking:
		return false
	$LaserRaycast/RayCast2D.fire()
	check_hit()
	is_attacking = false

func check_hit():
	var body = $LaserRaycast/RayCast2D.get_collider()
	if body != null and not body.is_ancestor_of(self):
		attack_hit.emit(body)

func _on_fire_animation_animation_looped():
	attack_end.emit()
	is_attacking = false
	$FireAnimation.stop()

