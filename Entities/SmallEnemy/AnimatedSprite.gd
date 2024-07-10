extends AnimatedSprite2D


func _on_health_pool_health_changed(_amount):
	play()
