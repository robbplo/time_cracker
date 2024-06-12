extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#Uses the function from the GameTime timer
	text = $GameTime._format_seconds()

