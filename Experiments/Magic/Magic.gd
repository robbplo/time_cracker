extends CharacterBody2D

# ⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀ ⠀⠀⠀⠀⢀⠀⠀⠀⠠⡶⠄⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀ ⠀⠀⠀⠀⠀⣨⣷⣧⣀⠀⠀⠀⠀⠐⣤⡴⠀
#⠀ ⠀⠀⠀⠀⠀ ⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠸⠀⡀⡀⠀⠀⠀⠈⢹⠋⠁
#⠀⠀ ⠀⠀⠀ ⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⢻⠓⠀⠸⡮⠄⠀⠀⠀
#⠀⠀⠀ ⠀ ⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⢀⠔⢲⠈⠀⠀⢀⠀⠀⠀⠼⡮
#⠀⠀⠀  ⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⢀⣴⣇⠔⠁⠀⠠⢷⠯⠀⠀⠀⠀⠀
#⠀⠀ ⠀⠀ ⠀ ⠀⠀⠀⠀⠀⠀⢀⣴⣿⠟⠁⠀⠀⠀⠀⠸⠀⠀⠀⠀⠀⠀
#⠀ ⠀⠀⠀⠀  ⠀⠀⠀⠀⢀⣴⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀⠀  ⠀⠀⠀⢀⣴⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀woah⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀⠀⠀  ⠀⠀⢀⣴⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀woah⠀⠀⠀
# ⠀⠀  ⠀⢀⣴⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# ⠀  ⢀⣴⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀woah ⠀⠀⠀⠀⠀⠀
#   ⡔⢁⠜⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀it's magic
#  ⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀


const BULLET = preload("res://Experiments/Magic/bullet.tscn")
@onready var MCircleComp: Area2D = $SubViewportContainer/SubViewport/MagicCircle
@onready var MCircle1: AnimationPlayer = $SubViewportContainer/SubViewport/MagicCircle/MCircles
@onready var MCircle2: AnimationPlayer = $SubViewportContainer/SubViewport/MagicCircle/MCircles_2
@onready var MCircle3: AnimationPlayer = $SubViewportContainer/SubViewport/MagicCircle/MCircles_3
@onready var MCircleSprites1: Sprite2D = $SubViewportContainer/SubViewport/MagicCircle/MCircleSheets_layer1
@onready var MCircleSprites2: Sprite2D = $SubViewportContainer/SubViewport/MagicCircle/MCircleSheets_layer2
@onready var MCircleSprites3: Sprite2D = $SubViewportContainer/SubViewport/MagicCircle/MCircleSheets_layer3

var spell_components: = []
var is_casting = false

func _ready():
	reset_MCircle()

func _process(_delta):
	if not is_casting:
		move_and_slide()
		reset_MCircle()
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
	update_MCircle(component)

## just fookin send it
func send_it():
	spell_components.clear()
	$RichTextLabel.text = ""
	fire_bullet()
	reset_MCircle()
	
	

## Hell yea brother
func fire_bullet():
	var bullet = BULLET.instantiate()
	bullet.direction = global_position.direction_to(get_global_mouse_position()).normalized()
	bullet.global_position = global_position
	get_tree().root.add_child(bullet)
	
func update_MCircle(component):
	if (spell_components.size() == 1):
		MCircle1.play(component)
		MCircleSprites1.visible = true
	elif (spell_components.size() == 2):
		MCircle2.play(component)
		MCircleSprites2.visible = true
	elif (spell_components.size() == 3):
		MCircle3.play(component)
		MCircleSprites3.visible = true
	
func reset_MCircle():
	MCircle1.stop()
	MCircleSprites1.visible = false
	MCircle2.stop()
	MCircleSprites2.visible = false
	MCircle3.stop()
	MCircleSprites3.visible = false

	
	
# force pushu
# (slightly) houming projectiles
# big rock that follows cursor
# laser insta raycast (SHOOT)
# airstrike fire column
# orbiter blessed hammer
# summon wall
# crash game
