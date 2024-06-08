extends CharacterBody2D

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	#var player = $"/root/Main/TimeContext/Player"
	#var direction = self.global_position.direction_to(player.global_position)
	#velocity = direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()

#@export var speed = 400
#var moving = true
#
#func get_input():
	#var player = get_node("/root/Main/TimeContext/Player")
	#var direction = self.global_position.direction_to(player.global_position)
	#print(direction)
	#velocity = direction * 100
	##print(velocity)
#
#func _physics_process(delta):
	##if moving:
	#get_input()
	#move_and_slide()
	#print(velocity)
#
#func step(distance):
	##var step_time = $"/root/Main/TimeContext".get_timer().wait_time / 2
	##speed = distance / step_time
	#moving = true
	##$StepTimer.start(step_time)
#
#func _on_step_timer_timeout():
	##print(moving)
	##moving = false
	#pass
