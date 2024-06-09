extends Node2D

const ENEMY = preload("res://enemy.tscn")

## Node that enemies will be added to
@onready var root = $"/root/Main/TimeContext"
@onready var player = root.get_node("Player")
@onready var camera: Camera2D = player.get_node("Camera2D")

@export var max_enemies = 20
@export var min_delay = 1
@export var max_delay = 5
## When the last enemy was spawned
var delay = 0.0
var enemy_count = 0

func _process(delta):
	delay += delta
	if delay > min_delay:
		if delay > max_delay:
			spawn()
		elif randf() > 0.97:
			spawn()

func spawn():
	if enemy_count >= max_enemies:
		return false
	var new_enemy = ENEMY.instantiate()
	new_enemy.connect("tree_exited", func(): enemy_count -= 1)
	# todo: how to properly set up attack signals?
	player.connect("attack_hit", new_enemy._on_player_attack_hit)
	new_enemy.connect("attack_hit", player._on_enemy_attack_hit)
	enemy_count += 1
	root.add_child(new_enemy)
	delay = 0
	return true
