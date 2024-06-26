extends Node2D

const ENEMY = preload("res://Entities/SmallEnemy/small_enemy.tscn")

## Node that enemies will be added to
@onready var root = get_parent()
@onready var player = root.get_node("Player")
@onready var camera: Camera2D = root.find_child("Camera2D")

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
		elif randf() > 0.93:
			spawn()

func spawn():
	if enemy_count >= max_enemies:
		return false
	var new_enemy = ENEMY.instantiate()

	new_enemy.tree_exited.connect(func(): enemy_count -= 1)
	new_enemy.attack_hit.connect(player._on_enemy_attack_hit)
	player.attack_hit.connect(new_enemy._on_player_attack_hit)

	# duplicate the material so parameters are separated
	var sprite = new_enemy.get_node("AnimatedSprite")
	var original_material = sprite.material
	if original_material and original_material is ShaderMaterial:
		var new_material = original_material.duplicate()
		sprite.material = new_material

	enemy_count += 1
	var pos = spawn_position()
	new_enemy.position = pos
	root.add_child(new_enemy)
	delay = 0
	return true

func spawn_position():
	var center = camera.get_screen_center_position()
	var min_x = center.x + 1000
	var max_x = center.x + 1500
	var min_y = center.y + 1000
	var max_y = center.y + 1500
	if randf() > 0.5:
		min_x *= -1
	if randf() > 0.5:
		max_x *= -1
	if randf() > 0.5:
		min_y *= -1
	if randf() > 0.5:
		max_y *= -1
	return Vector2(randi_range(min_x, max_x), randi_range(min_y, max_y))
