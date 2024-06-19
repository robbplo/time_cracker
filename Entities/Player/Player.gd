extends CharacterBody2D


@onready var animation_tree : AnimationTree = $AnimationTree
 
var input_direction: Vector2 = Vector2.ZERO

signal attack_hit
signal hurt(damage: int)

var speed = 250
var damage = 1

func _ready():
	animation_tree.active = true

func _process(delta):
	update_animations()

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down").normalized()
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
	if (Input.is_action_just_pressed("Attack")):
		attack()

func _on_attack_attack_hit(body: Node):
	attack_hit.emit(body, damage)

func _on_enemy_attack_hit(amount):
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
