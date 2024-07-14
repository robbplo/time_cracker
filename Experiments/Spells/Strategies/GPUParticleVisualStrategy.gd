class_name GPUParticleVisualStrategy extends VisualStrategy

@export var process_material: ParticleProcessMaterial

const EMITTER_SCENE = preload("res://Experiments/Spells/spell_gpu_particles.tscn")

func apply(spell: Spell):
	var emitter = EMITTER_SCENE.instantiate()
	var t = emitter.create_tween()
	emitter.emitting = true
	emitter.amount_ratio = 1.0
	process_material.initial_velocity_min = 60.0
	process_material.initial_velocity_max = 90.0
	emitter.process_material = process_material
	t.set_trans(Tween.TRANS_QUAD)
	t.set_ease(Tween.EASE_OUT)
	t.tween_property(emitter, "amount_ratio", 0.0, spell.duration)
	t.tween_property(emitter.process_material, "initial_velocity_min", 2.0, spell.duration)
	t.tween_property(emitter.process_material, "initial_velocity_max", 3.0, spell.duration)
	t.tween_callback(emitter.queue_free)
	spell.get_tree().root.add_child(emitter)
