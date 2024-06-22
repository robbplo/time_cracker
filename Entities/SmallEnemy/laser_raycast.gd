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
		var direction = global_position.direction_to(target.global_position)
		# extend past target node by distance of 1000
		target_position = direction * 1000
		if is_colliding():
			cast_point = to_local(get_collision_point())

	$Line2D.points[1] = cast_point
	$Line2D2.points[1] = cast_point

## fire laser animations
func fire():
	is_casting = true
	var tween = create_tween()
	# grow laser
	tween.tween_property($Line2D, "width", 40, .02)
	tween.parallel().tween_property($Line2D2, "width", 35, .02)
	# shrink laser
	tween.tween_property($Line2D, "width", 0, .4)
	tween.parallel().tween_property($Line2D2, "width", 0, .4)
	# stop casting and tracking
	tween.tween_property(self, "is_casting", false, .0)
	tween.parallel().tween_property(self, "is_tracking", false, .0)
