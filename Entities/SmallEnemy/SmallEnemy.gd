extends Character

@export var movement_curve: Curve
var target = null
var speed = 0
@export var damage = 2.0
## Starts attacking if target is within n meters
@export var attack_range: int = 600

func _ready():
	super._ready()
	target = get_parent().get_node("Player")
	$Attack.set_target(target)

func get_target():
	if target != null && is_instance_valid(target):
		return target

func _physics_process(_delta):
	move_and_slide()
	velocity *= .9

## Move for 'distance' meters
## Speed is calculated so the movement occurs an eigth note
func step(distance):
	var step_time = GlobalTimer.quarter_note_duration / 2.0
	speed = distance / step_time
	target = get_target()
	if target:
		var direction = self.global_position.direction_to(target.global_position)
		velocity = direction * speed

## Emit signal if player was hit
func _on_attack_attack_hit(body):
	if body is Player:
		body.take_damage(damage)

## Start charging attack
func charge_attack():
	var global_distance = self.global_position.distance_to(target.global_position)
	if global_distance < attack_range:
		$Attack.charge()
		$AnimationPlayer.play("open")
		$AnimationPlayer.queue("loop_charging")

## If charging, fire attack
func fire_attack():
	if $Attack.is_attacking:
		$AnimationPlayer.play("fire")
		$AnimationPlayer.queue("idle")
