extends CharacterBody2D

const BULLET = preload("res://Experiments/Magic/bullet.tscn")

var spell_components: = []
var is_casting = false

func _ready():
	pass

func _process(_delta):
	if not is_casting:
		var direction = Input.get_vector("left", "right", "up", "down").normalized()
		velocity = direction * 400
		move_and_slide()
	else:
		if Input.is_action_just_pressed("left"):
			add_component("left")
		if Input.is_action_just_pressed("right"):
			add_component("right")
		if Input.is_action_just_pressed("up"):
			add_component("up")
		if Input.is_action_just_pressed("down"):
			add_component("down")

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_casting = event.is_pressed()
			if event.is_released():
				send_it()

func add_component(component):
	print(GlobalTimer.distance_to_quarter_note())
	if not GlobalTimer.is_on_time():
		return
	spell_components.append(component)
	$RichTextLabel.text = ", ".join(spell_components)

## just fookin send it
func send_it():
	print(spell_components)
	spell_components.clear()
	$RichTextLabel.text = ""
	fire_bullet()

func fire_bullet():
	var bullet = BULLET.instantiate()
	print(bullet.direction)
	bullet.direction = global_position.direction_to(get_global_mouse_position()).normalized()
	bullet.global_position = global_position
	get_tree().root.add_child(bullet)

# force pushu
# (slightly) houming projectiles
# big rock that follows cursor
# laser insta raycast (SHOOT)
# airstrike fire column
# orbiter blessed hammer
# summon wall



