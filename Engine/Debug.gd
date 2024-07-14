##
## Helper functions for debugging
##
extends Node

const SHAPE_LIFETIME = 2.0

## Spawn a sphere at a point in global space so you don't have to print your Vector3 :)
func show_point(point: Vector3):
	var sphere := CSGSphere3D.new()
	sphere.global_position = point
	get_tree().root.add_child(sphere)
	var t := sphere.create_tween()
	t.tween_property(sphere, "radius", sphere.radius / 100, SHAPE_LIFETIME)
	t.tween_callback(sphere.queue_free)

## Display a collision shape in the world. Position argument is a global and there is the option to
## pass a Transform3D as the third argument to transform the created mesh.
func show_shape3d(shape: Shape3D, position: Vector3, transform: Transform3D = Transform3D.IDENTITY):
	var mesh_instance := MeshInstance3D.new()
	mesh_instance.mesh = shape.get_debug_mesh()
	mesh_instance.create_debug_tangents() #??
	mesh_instance.position = position
	mesh_instance.transform = transform
	get_tree().root.add_child(mesh_instance)
	var t := mesh_instance.create_tween()
	t.tween_callback(mesh_instance.queue_free).set_delay(SHAPE_LIFETIME)
