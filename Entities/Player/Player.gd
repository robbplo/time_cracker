extends Character
class_name Player

const CAMERA_Y_ROTATION = 45

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine = $AnimationTree.get("parameters/playback")

@export var base_speed: float = 5.0
@export var damage: float = 1.0
@export var dash_speed_factor: float = 8.0
@export var dash_duration: float = 0.15
@export var dash_cooldown: float = 1.0

var input_dir: Vector2 = Vector2.ZERO
## Actual movement speed, modified by dashing
var speed: float = base_speed
var is_dashing = false
var is_casting = false

func _ready():
	super._ready()
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	get_input(delta)
	handle_movement()

func _process(_delta):
	update_animations()

func get_input(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("dash"):
		dash()

	input_dir = Input.get_vector("left", "right", "up", "down").rotated(deg_to_rad(-CAMERA_Y_ROTATION))

	if Input.is_action_just_pressed("attack"):
		is_casting = true
	if Input.is_action_just_released("attack"):
		is_casting = false
		state_machine.travel("Idle")

func handle_movement():
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	# Cannot move while casting
	if direction and not is_casting:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	move_and_slide()

## Dash has iframes equal to dash_duration
func dash():
	if is_dashing or not is_on_floor():
		return false
	is_dashing = true
	is_invulnerable = true
	speed = base_speed * dash_speed_factor
	var tween = create_tween()
	tween.tween_property(self, "speed", base_speed, dash_duration)
	tween.parallel().tween_callback(func():
		is_dashing = false
		is_invulnerable = false
		).set_delay(dash_cooldown)

func die():
	get_tree().change_scene_to_file("res://Levels/death_screen.tscn")

func update_animations():
	var direction = input_dir.rotated(deg_to_rad(CAMERA_Y_ROTATION))
	var is_idle = direction == Vector2.ZERO
	animation_tree["parameters/conditions/Idle"] = is_idle
	animation_tree["parameters/conditions/is_moving"] = not is_idle
	animation_tree["parameters/conditions/is_casting"] = is_casting
	if direction:
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Run/blend_position"] = direction
