extends Character
class_name Player

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine = $AnimationTree.get("parameters/playback")

@export var base_speed: float = 250.0
@export var damage: float = 1.0
@export var dash_speed_factor: float = 4.0
@export var dash_duration: float = 0.3
@export var dash_cooldown: float = 1.0

var input_direction: Vector2 = Vector2.ZERO
## Actual movement speed, modified by dashing
var speed: float = base_speed
var is_dashing = false
var is_casting = false

func _ready():
	super._ready()
	animation_tree.active = true

func _process(_delta):
	update_animations()

func _physics_process(_delta):
	get_input()
	move_and_slide()

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	if Input.is_action_just_pressed("Dash") and input_direction != Vector2.ZERO:
		dash()
	velocity = input_direction * speed
	if Input.is_action_just_pressed("Attack"):
		is_casting = true
	if Input.is_action_just_released("Attack"):
		is_casting = false
		state_machine.travel("Idle")
	if is_casting:
		velocity = Vector2.ZERO

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

func die():
	get_tree().change_scene_to_file("res://Levels/death_screen.tscn")

func update_animations():
	var is_idle = velocity == Vector2.ZERO
	animation_tree["parameters/conditions/Idle"] = is_idle
	animation_tree["parameters/conditions/is_moving"] = not is_idle

	animation_tree["parameters/conditions/is_casting"] = is_casting

	if not $Attack.is_attacking:
		if input_direction != Vector2.ZERO:
			animation_tree["parameters/Idle/blend_position"] = input_direction
			animation_tree["parameters/Run/blend_position"] = input_direction
