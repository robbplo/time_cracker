extends RayCast2D

var is_casting = false
var is_tracking = true
var target: Node2D = null

func _process(_delta):
	update_laser()

## enable tracking beam and follow the target
func start_tracking():
	is_tracking = true
	# update immediately so laser will not appear in last position
	update_laser()
	$Line2D.width = 2

## stop following the target
func stop_tracking():
	is_tracking = false

## update laser position based on target location
func update_laser():
	var cast_point = target_position

	if is_tracking && target:
		# extend past target node by a static length
		var direction = global_position.direction_to(target.global_position)
		target_position = direction * 2000

	if is_colliding() and not is_casting:
		cast_point = to_local(get_collision_point())

	$Line2D.points[1] = cast_point
	$Line2D2.points[1] = cast_point

func fire():
	is_casting = true
	$AnimationPlayer.play("fire")

func point_light_at_target():
	$Lights.look_at(to_global($Line2D.points[1]))
