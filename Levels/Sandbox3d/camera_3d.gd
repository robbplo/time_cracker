extends Camera3D

var xp: Vector2
var y: Vector2
var yd: Vector2
var k1: float
var k2: float
var k3: float
var x0: Vector2 = Vector2.ZERO

## Frequency of the system in Hz
## Affects the overall speed of the system
@export_range(-10.0, 10, .1) var frequency: float = 1.0
## Damping coefficient 'zeta'
## Describes how the system settles
## 0 is no damping or infinite oscillation
## Between 0 and 1 there is some vibration and overshooting
## Greater than one there is no vibration and the system settles without overshooting
@export_range(-10.0, 10, .1) var damping: float = 0.5
## response controls the initial response to a change in the system
## At 0 the system will have a delayed response to changes
## At 1 the system will respond immediately
## At greater than 1 the system will overshoot its value
## At negative values the system will start by moving in the opposite direction
@export_range(-10.0, 10, .1) var response: float = 2.0

func _ready():
	k1 = damping / (PI * frequency)
	k2 = 1 / ((2 * PI * frequency) * (2 * PI * frequency))
	k3 = response * damping / (2 * PI * frequency)
	xp = x0
	y = x0
	yd = Vector2.ZERO

func _process(delta):
	var target: Vector3 = $"../Player".global_position
	var offset := Vector2(0, 15)
	var new_pos := update(delta, Vector2(target.x, target.z) + offset)
	global_position.x = new_pos.x
	global_position.z = new_pos.y
	global_position.y = target.y + 10

func update(T: float, x: Vector2, xd: Vector2 = Vector2.ZERO) -> Vector2:
	if (not xd):
		xd = (x - xp) / T
		xp = x
	var k2_stable = max(k2, T*T/2 + T*k1/2, T*k1)
	y = y + T * yd
	yd = yd + T * (x + k3*xd - y - k1*yd) / k2_stable
	return y
