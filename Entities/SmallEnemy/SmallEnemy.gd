extends CharacterBody2D

signal attack_hit(damage: int)
signal hurt(damage: int)

var target = null
## Movement speed, controlled by movement duration
var speed = 0
var is_moving = false
@export var damage = 2.0
## Starts attacking if target is within n pixels
@export var attack_range: int = 400

func _ready():
	target = get_parent().get_node("Player")
	$Attack.set_target(target)

	GlobalTimer.sixteenth_note.connect(_on_sixteenth_note)

func get_target():
	if target != null && is_instance_valid(target):
		return target

func get_input():
	target = get_target()
	if target:
		var direction = self.global_position.direction_to(target.global_position)
		velocity = direction * speed

func _physics_process(_delta):
	if is_moving:
		get_input()
		move_and_slide()

func step(distance):
	var step_time = GlobalTimer.quarter_note_duration / 2.0
	speed = distance / step_time
	is_moving = true
	await get_tree().create_timer(step_time).timeout
	is_moving = false

func _on_health_pool_die():
	queue_free()

func _on_player_attack_hit(body, amount):
	if body == self:
		hurt.emit(amount)
		$HealthPool.subtract(amount)

func _on_attack_attack_hit(body):
	if body.name == "Player":
		attack_hit.emit(damage)

func _on_sixteenth_note(index):
	match index:
		4: step(150)
		8: charge_attack()
		14: $Attack/LaserRaycast.stop_tracking()
		15: fire_attack()

## Start charging attack
func charge_attack():
	var global_distance = self.global_position.distance_to(target.global_position)
	if global_distance < attack_range:
		$Attack.charge()
		$AnimationPlayer.play("open")
		$AnimationPlayer.queue("loop_charging")

## Fire attack after a short delay
func fire_attack():
	var delay = GlobalTimer.sixteenth_note_duration * .75
	await get_tree().create_timer(delay).timeout
	$AnimationPlayer.play("fire")
	$AnimationPlayer.queue("idle")
