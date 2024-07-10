extends Spell
class_name Blink

var max_distance = 200.0
## TODO: decouple player reference
@onready var player: Player = get_parent().get_parent()

func cast():
	var target_pos = player.get_local_mouse_position()
	var distance = target_pos.length()
	if distance > max_distance:
		# Scale position vector by ratio of target distance to max
		target_pos *= (max_distance / distance)
	player.translate(target_pos)
