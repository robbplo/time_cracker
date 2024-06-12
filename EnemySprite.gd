extends Sprite2D

func _ready():
	material.set_shader_parameter("bpm", GlobalTimer.bpm)
	material.set_shader_parameter("flash_mix", 0)

func _on_enemy_hurt(_damage):
	material.set_shader_parameter("flash_mix", .7)
	await(get_tree().create_timer(.1).timeout)
	material.set_shader_parameter("flash_mix", 0)
