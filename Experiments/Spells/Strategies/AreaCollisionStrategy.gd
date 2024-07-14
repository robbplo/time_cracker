class_name AreaCollisionStrategy extends CollisionStrategy
# TODO: should strategies be resources or nodes?

@export var shape: Shape3D
@export var origin: Vector3 = Vector3.ZERO

func get_colliders(spell: Spell) -> Array[Character]:
	var query = PhysicsShapeQueryParameters3D.new()
	query.shape = shape
	var transform = Transform3D.IDENTITY.looking_at(spell.targeting_strategy.get_target())
	transform.origin = origin
	query.transform = transform

	if spell.get_tree().debug_collisions_hint:
		Debug.show_shape3d(shape, spell.targeting_strategy.get_origin(), transform)

	var space_state := spell.get_world_3d().direct_space_state
	var results := space_state.intersect_shape(query)
	var colliders: Array[Character] = []
	for result in results:
		var collider = result["collider"]
		if collider is Character:
			colliders.append(collider)
			collided.emit(collider)
	return colliders
