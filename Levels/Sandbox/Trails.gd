extends Line2D

var queue : Array
@export var Max_length: int



func _physics_process(delta):
	var pos = get_parent().position
	
	queue.push_front(pos)
	
	if queue.size() > Max_length:
		queue.pop_back()
		
	clear_points()
	
	for point in queue:
		add_point(point)
		
	z_index = get_parent().z_index
