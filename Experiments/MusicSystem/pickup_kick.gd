extends Area2D

@export var track : AudioStreamPlayer
@export var sprite: Texture2D


signal pickup_item(track)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if (body.name == "Player"):
		track.volume_db = 0.0
		queue_free()
