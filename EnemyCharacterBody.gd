extends CharacterBody2D
class_name Enemy

signal attack_hit

@onready var target = $"/root/Main/TimeContext/Player"
## Movement speed, overridden by movement duration
@export var speed = 600
## Fraction of the beat in which the movement occurs.
@export var movement_duration = 1.0/4
@export var damage = 2
var moving = false

func get_target():
	if is_instance_valid(target):
		return target

func get_input():
	target = get_target()
	if target:
		var direction = self.global_position.direction_to(target.global_position)
		velocity = direction * speed

func _physics_process(_delta):
	if moving:
		get_input()
		move_and_slide()

func step(distance):
	var step_time = $"/root/Main/TimeContext".get_timer().wait_time * movement_duration
	speed = distance / step_time
	moving = true
	$StepTimer.start(step_time)
	
func die():
	queue_free()

func _on_step_timer_timeout():
	moving = false

func _on_health_pool_die():
	die()

func _on_player_attack_hit(body, damage):
	if body == self:
		$HealthPool.subtract(damage)

func _on_attack_attack_hit(body):
	if body.name == "Player":
		print("emit player hit")
		emit_signal("attack_hit", damage)
