extends CharacterBody2D

@onready var attackSwish = $Attack/AttackSwish

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouse \
	and event.button_mask == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		$Attack.start(get_global_mouse_position())
		var SfxPitch = randf_range(0.95,1.1)
		$Attack/AttackSwish.set_pitch_scale(SfxPitch)
		$Attack/AttackSwish.play(0.10)
		
