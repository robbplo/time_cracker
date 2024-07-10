extends Node2D

## https://docs.godotengine.org/en/4.2/tutorials/math/matrices_and_transforms.html

func _ready():
	$LaserRaycast.track_target($Cube3)

func _physics_process(delta):
	cube3(delta, $Player)



# predicts the position of target based on its velocity
# does not track spinning objects very well, but moves tangentially
var prev_target_pos = Vector2.ZERO
func cube3(delta, target):
	if prev_target_pos == Vector2.ZERO:
		prev_target_pos = target.position
		pass
	# delta of target position with previous frame.
	var delta_pos = (target.position - prev_target_pos)
	var velocity = delta_pos / delta

	var destination = target.position + velocity
	var difference = destination - $Cube3.position

	prev_target_pos = target.position
	$Cube3.position += (difference / 5)
