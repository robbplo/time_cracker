extends CharacterBody2D

signal attack_start
signal attack_end
signal attack_hit(body: CharacterBody2D)

var is_attacking = false

func start(target: Vector2):
	if not start_attack(target):
		return false
	check_hit()
	return true

func start_attack(_target: Vector2):
	if is_attacking:
		return false
	attack_start.emit()
	is_attacking = true
	return true

func check_hit():
	pass

func _on_animation_tree_animation_finished(anim_name:StringName):
	if anim_name in ["R_Slash1", "L_Slash1"]:
		attack_end.emit()
		is_attacking = false



func _on_area_2d_body_entered(body):
	if not is_attacking:
		return false
	if not body.is_ancestor_of(self):
		attack_hit.emit(body)
