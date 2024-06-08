extends TimedNode2D

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	set_actions([
		func(): $EnemyCharacterBody/Attack.start($"/root/Main/TimeContext/Player".global_position),
		func(): $EnemyCharacterBody.step(50),
		func(): $EnemyCharacterBody.step(50),
		func(): $EnemyCharacterBody.step(150),
	])


