extends StaticBody2D

@export_node_path var target: NodePath

func _physics_process(_delta):
	if target != null:
		spin_around(get_node(target))

# Velocity in radians/second
#var velocity = 10.0
var distance = 100.0
var pos = Vector2.RIGHT * distance
# spins around cube 2
func spin_around(node):
	var angle = .03
	# create rotation matrix for angle in radians
	var t = Transform2D()
	t.x.x = cos(angle)
	t.y.x = -sin(angle)
	t.x.y = sin(angle)
	t.y.y = cos(angle)
	# apply rotation in reverse
	pos = (pos * t.inverse())
	position = pos + node.position
