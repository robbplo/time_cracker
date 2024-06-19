extends CharacterBody2D

signal attack_hit(damage: int)
signal hurt(damage: int)

@onready var target = get_parent().get_node("Player")
## Movement speed, overridden by movement duration
var speed = 600
@export var damage = 2
var moving = false

func _ready():
	GlobalTimer.sixteenth_note.connect(_on_sixteenth_note)

func get_target():
	if is_instance_valid(target):
		return target

func get_input():
	target = get_target()
	if target:
		var direction = self.global_position.direction_to(target.global_position)
		velocity = direction * speed

func _physics_process(_delta):
	if moving:
		get_input()
		move_and_slide()

func step(distance):
	var step_time = GlobalTimer.quarter_note_duration / 1000.0 / 2.0
	speed = distance / step_time
	moving = true
	await get_tree().create_timer(step_time).timeout
	moving = false

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
		# 0: $Attack.fire()
		4: step(150)
		8:
			$Attack.charge(target)
			$AnimationPlayer.play("open")
			$AnimationPlayer.queue("loop_charging")
		14: $Attack.stop_tracking()
		15:
			var delay = GlobalTimer.sixteenth_note_duration / 1000.0 * .75
			await get_tree().create_timer(delay).timeout
			$AnimationPlayer.play("fire")
			$AnimationPlayer.queue("idle")

func attack():
	if self.global_position.distance_to(target.global_position) < 600:
		$Attack.start(target.global_position)
	return true
