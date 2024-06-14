extends CharacterBody2D

signal attack_hit
signal hurt(damage: int)

var speed = 400
var damage = 1

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()

func attack():
	if not GlobalTimer.is_on_time():
		return false
	if !$Attack.start(get_global_mouse_position()):
		return false

func _unhandled_input(event):
	if event is InputEventMouse \
	and event.button_mask == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		attack()

func _on_attack_attack_hit(body: Node):
	attack_hit.emit(body, damage)

func _on_enemy_attack_hit(amount):
	hurt.emit(amount)
	$HealthPool.subtract(damage)

func _on_health_pool_die():
	get_tree().change_scene_to_file("res://Levels/death_screen.tscn")
