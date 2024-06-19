extends RayCast2D

var is_casting = false
var should_collide = false

# only runs when casting
func _physics_process(_delta):
	var cast_point = target_position
	if is_colliding():
		if not is_casting:
			cast_point = to_local(get_collision_point())
	$Line2D.points[1] = cast_point
	$Line2D2.points[1] = cast_point

func fire():
	is_casting = true
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 40, .02)
	tween.parallel().tween_property($Line2D2, "width", 35, .02)

	tween.tween_property($Line2D, "width", 0, .4)
	tween.parallel().tween_property($Line2D2, "width", 0, .4)
	tween.tween_callback(func(): is_casting = false)

