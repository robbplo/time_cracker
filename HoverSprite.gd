extends Sprite2D


func _ready():
	var shader_material = self.material
	if shader_material is ShaderMaterial:
		shader_material.set_shader_parameter("bpm", $"/root/Main/TimeContext".bpm)
