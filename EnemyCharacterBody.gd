extends CharacterBody2D

@export var speed = 600
## Fraction of the beat in which the movement occurs.
@export var movement_duration = 1.0/4
var moving = false

func get_input():
	var player = $"/root/Main/TimeContext/Player"
	var direction = self.global_position.direction_to(player.global_position)
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
