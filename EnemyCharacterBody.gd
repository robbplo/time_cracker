extends CharacterBody2D

@export var speed = 600
var moving = false

func get_input():
	var player = $"/root/Main/TimeContext/Player"
	var direction = self.global_position.direction_to(player.global_position)
	velocity = direction * speed

func _physics_process(delta):
	if moving:
		get_input()
		move_and_slide()

func step(distance):
	var step_time = $"/root/Main/TimeContext".get_timer().wait_time / 4
	speed = distance / step_time
	moving = true
	$StepTimer.start(step_time)

func _on_step_timer_timeout():
	moving = false
