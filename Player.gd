extends CharacterBody2D

signal attack_hit

@export var speed = 400
@export var damage = 1

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
	
func attack():
	if $"/root/Main/TimeContext".is_on_time(75):
		# reduce remaining time by 1 second
		var time = $"/root/Main/Label/GameTime".time_left
		$"/root/Main/Label/GameTime".start(time - 1.0)
		return false
	if !$Attack.start(get_global_mouse_position()):
		return false
	var SfxPitch = randf_range(0.95,1.1)
	$Attack/AttackSwish.set_pitch_scale(SfxPitch)
	$Attack/AttackSwish.play(0.10)

func _unhandled_input(event):
	if event is InputEventMouse \
	and event.button_mask == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		attack()

func _on_attack_attack_hit(body: Node):
	emit_signal("attack_hit", body, damage)

func _on_enemy_attack_hit(damage):
	$HealthPool.subtract(damage)

func _on_health_pool_die():
	get_tree().change_scene_to_file("res://death_screen.tscn")
