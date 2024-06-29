extends Polygon2D

@export var orbitRadius: float
@export var orbitSpeed: float
@export var exponent: float
@export var exponentSpeed: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	z_index = 1
	var playerposition = get_parent().position
	position.x = playerposition.x + (sin(GlobalTimer.elapsed_time*orbitSpeed)*orbitRadius*1.5) + (sin(GlobalTimer.elapsed_time*exponentSpeed)*exponent)
	position.y = playerposition.y + (cos(GlobalTimer.elapsed_time*orbitSpeed)*orbitRadius) + (sin(GlobalTimer.elapsed_time*exponentSpeed)*exponent*1.5)
	
	if position.y < playerposition.y:
		z_index = z_index-2
	
