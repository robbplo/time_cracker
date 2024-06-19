extends CharacterBody2D

signal attack_hit
signal hurt(damage: int)

@onready var animation_tree : AnimationTree = $AnimationTree

@export var base_speed: float = 250.0
@export var damage: float = 1.0
@export var dash_speed_factor: float = 4.0
@export var dash_duration: float = 0.3
@export var dash_cooldown: float = 1.0

var input_direction: Vector2 = Vector2.ZERO
## Actual movement speed, modified by dashing
var speed: float = base_speed
var is_dashing = false
var is_invulnerable = false

func _ready():
	animation_tree.active = true

func _process(_delta):
	update_animations()

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	if Input.is_action_just_pressed("Dash") and input_direction != Vector2.ZERO:
		dash()
	velocity = input_direction * speed

## Dash has iframes equal to dash_duration
func dash():
	if is_dashing:
		return false
	is_dashing = true
	is_invulnerable = true
	var tween = create_tween()
	speed = base_speed * dash_speed_factor
	tween.tween_property(self, "speed", base_speed, dash_duration)
	tween.tween_callback(func(): is_invulnerable = false)
	await get_tree().create_timer(dash_cooldown).timeout
	is_dashing = false

func _physics_process(_delta):
	get_input()
	move_and_slide()

func attack():
	if not GlobalTimer.is_on_time():
		return false
	if !$Attack.start(get_global_mouse_position()):
		return false

func _unhandled_input(_event):
	if (Input.is_action_just_pressed("Attack")):
		attack()

func _on_attack_attack_hit(body: Node):
	attack_hit.emit(body, damage)

func _on_enemy_attack_hit(amount):
	# do not take damage during iframes
	if is_invulnerable:
		return
	hurt.emit(amount)
	$HealthPool.subtract(damage)

func _on_health_pool_die():
	get_tree().change_scene_to_file("res://Levels/death_screen.tscn")


func update_animations():

	if (velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/Idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/Idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true

	if (Input.is_action_just_pressed("Attack")):
		animation_tree["parameters/conditions/Attack"] = true
	else:
		animation_tree["parameters/conditions/Attack"] = false

	if(input_direction != Vector2.ZERO):
		animation_tree["parameters/Idle/blend_position"] = input_direction
		animation_tree["parameters/Run/blend_position"] = input_direction
		animation_tree["parameters/Slash1/blend_position"] = input_direction
