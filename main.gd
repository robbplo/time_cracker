extends Node2D


func _unhandled_input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			if OS.is_debug_build():
				get_tree().quit()
