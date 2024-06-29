extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	
	for _i in range(-300, 330):
		for _j in range (-300,300):
			set_cell(Vector2(_i,_j), 0, Vector2i(randi_range(0,3),randi_range(0,3)))
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
