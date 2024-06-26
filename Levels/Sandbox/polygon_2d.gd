extends Polygon2D

@export var orbitRadius: float
@export var orbitSpeed: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	z_index = 1
	var playerposition = get_parent().position
	position.x = playerposition.x + (sin(GlobalTimer.elapsed_time*orbitSpeed)*orbitRadius)
	position.y = playerposition.y + (cos(GlobalTimer.elapsed_time*orbitSpeed)*orbitRadius)
	
	if position.y < playerposition.y:
		z_index = z_index-1
	
