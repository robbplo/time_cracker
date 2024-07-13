extends Node3D

var spell_components: = []
var is_casting = false

var mCircle_currentFrame = 0
var mCircle_toFrame = 0

func _process(_delta):
	if is_casting:
		if Input.is_action_just_pressed("left"):
			add_component("left")
		elif Input.is_action_just_pressed("right"):
			add_component("right")
		elif Input.is_action_just_pressed("up"):
			add_component("up")
		elif Input.is_action_just_pressed("down"):
			add_component("down")


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_casting = event.is_pressed()
			if event.is_released():
				send_it()

func add_component(component):
	if not GlobalTimer.is_on_time():
		return
	spell_components.append(component)
	$Label3D.text = ", ".join(spell_components)

## just fookin send it
func send_it():
	match spell_components:
		["up"]: $ForcePush.cast()
		["down"]: $Blink.cast()
		["left"]: $Projectile.cast()
		["right"]: $Spike.cast()
		_: pass

	spell_components.clear()
	$Label3D.text = ""
