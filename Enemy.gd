extends TimedNode2D

# Called when the node enters the scene tree for the first time.
func _ready():
	set_actions([
		#func(): print("attack"),
		#func(): $EnemyCharacterBody.step(100),
		#func(): $EnemyCharacterBody.step(100),
		#func(): $EnemyCharacterBody.step(150),
	])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
