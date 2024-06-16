extends RayCast2D

var is_casting = false

func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_mask = MOUSE_BUTTON_LEFT

func _physics_process(_delta):
	var cast_point = target_position

	# is this necessary?
	force_raycast_update()
	if is_colliding():
		cast_point = get_collision_normal()
	$Line2D.points[1] = cast_point

func set_is_casting(cast):
	is_casting = cast
	set_physics_process(is_casting)
