extends CharacterBody2D

signal attack_hit(damage: int)
signal hurt(damage: int)

@export var movement_curve: Curve
var target = null
## Movement speed, controlled by movement duration
var speed = 0
@export var damage = 2.0
## Starts attacking if target is within n pixels
@export var attack_range: int = 800

func _ready():
	target = get_parent().get_node("Player")
	$Attack.set_target(target)

func get_target():
	if target != null && is_instance_valid(target):
		return target

var acceleration = 0.0
var deceleration = 10.0
func _physics_process(_delta):
	move_and_slide()
	velocity *= .9

## Move for 'distance' pixels
## Speed is calculated so the movement occurs an eigth note
func step(distance):
	var step_time = GlobalTimer.quarter_note_duration / 2.0
	speed = distance / step_time
	target = get_target()
	if target:
		var direction = self.global_position.direction_to(target.global_position)
		velocity = direction * speed

func _on_health_pool_die():
	queue_free()

## Subtract health when hit by player
func _on_player_attack_hit(body, amount):
	if body == self:
		hurt.emit(amount)
		$HealthPool.subtract(amount)

## Emit signal if player was hit
func _on_attack_attack_hit(body):
	if body.name == "Player":
		attack_hit.emit(damage)

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
