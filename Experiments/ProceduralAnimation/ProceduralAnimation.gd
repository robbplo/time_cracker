extends Node3D
class_name ProceduralAnimation

## Procedural Animation using second order systems
##
## reference: https://www.youtube.com/watch?v=KPoeNZZ6H4s

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
## r controls the initial response to a change in the system
## At 0 the system will have a delayed response to changes
## At 1 the system will respond immediately
## At greater than 1 the system will overshoot its value
## At negative values the system will start by moving in the opposite direction
@export_range(-10.0, 10, .1) var response: float = 2.0
## Node which should be followed
@export var target: Node3D

func _ready():
	k1 = damping / (PI * frequency)
	k2 = 1 / ((2 * PI * frequency) * (2 * PI * frequency))
	k3 = response * damping / (2 * PI * frequency)
	xp = x0
	y = x0
	yd = Vector2.ZERO

func _process(delta):
	var pos := target.global_position
	var new_pos := update(delta, Vector2(pos.x, pos.z))
	global_position.x = new_pos.x
	global_position.z = new_pos.y

func update(T: float, x: Vector2, xd: Vector2 = Vector2.ZERO) -> Vector2:
	if (not xd):
		xd = (x - xp) / T
		xp = x
	var k2_stable = max(k2, T*T/2 + T*k1/2, T*k1)
	y = y + T * yd
	yd = yd + T * (x + k3*xd - y - k1*yd) / k2_stable
	return y
