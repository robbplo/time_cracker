extends RayCast2D

var is_casting = false
var should_collide = false
var target: Node2D = null

# only runs when casting
func _physics_process(_delta):
	var local_target
	if target != null:
		# get local position of target node
		local_target = target.global_position

	var cast_point = target_position
	if is_colliding():
		# only collide with objects when not casting
		if not is_casting:
			cast_point = to_local(get_collision_point())
	if local_target != null:
		var direction = global_position.direction_to(local_target)
		# extend past target node by distance of 1000
		target_position = direction * 1000

	$Line2D.points[1] = cast_point
	$Line2D2.points[1] = cast_point

func track_target(node: Node2D):
	target = node
	$Line2D.width = 2

func fire():
	is_casting = true
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 40, .02)
	tween.parallel().tween_property($Line2D2, "width", 35, .02)
	tween.tween_property($Line2D, "width", 0, .4)
	tween.parallel().tween_property($Line2D2, "width", 0, .4)
	tween.tween_callback(func(): is_casting = false)

