extends RayCast3D

var is_casting = false
var is_tracking = true
var target: Node3D = null

func _process(_delta):
	update_laser()

## enable tracking beam and follow the target
func start_tracking():
	is_tracking = true
	update_laser()

## stop following the target
func stop_tracking():
	is_tracking = false

## update laser position based on target location
func update_laser():
	var cast_point := target_position
	if is_tracking && target:
		var tracking_pos = target.global_position
		tracking_pos.y += self.position.y
		# extend past target node by a static length
		var direction = global_position.direction_to(tracking_pos)
		target_position = direction * 2000

		$Beam.look_at(tracking_pos, Vector3.UP)

	if is_colliding() and not is_casting:
		cast_point = to_local(get_collision_point())

	var length = cast_point.length()
	print(length)
	$"Beam/Cyl".height = length
	$"Beam/Cyl".position.z = -length / 2

func fire():
	is_casting = true
	$AnimationPlayer.play("fire")

func stop_casting():
	is_casting = false
