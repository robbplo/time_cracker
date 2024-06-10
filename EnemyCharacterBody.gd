extends CharacterBody2D
class_name Enemy

signal attack_hit(damage: int)

@onready var target = $"/root/Main/TimeContext/Player"
## Movement speed, overridden by movement duration
@export var speed = 600
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
	var step_time = $"/root/Main/TimeContext".get_timer().wait_time
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
		attack_hit.emit(damage)

func _on_time_proxy_beat(current_beat):
	match current_beat % 16:
		0: $Attack.check_hit()
		4: step(50)
		8: step(50)
		12: step(150)
		13: $Attack.start_attack(target.global_position)
