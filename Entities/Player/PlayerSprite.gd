extends Sprite2D

#func _ready():
	#material.set_shader_parameter("flash_mix", 0)

#func _on_player_hurt(_damage):
#	material.set_shader_parameter("flash_mix", .7)
#	await get_tree().create_timer(.1).timeout
#	material.set_shader_parameter("flash_mix", 0)

#func _ready():
	#material.set_shader_param("nb_frames",Vector2(hframes, vframes))
#
#
#func _process(delta):
	#material.set_shader_param("frame_coords",frame_coords)
	#material.set_shader_param("velocity",get_parent().velocity)
