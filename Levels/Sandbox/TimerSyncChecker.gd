extends Node
class_name TimerSyncChecker

func _ready():
	start()

func start():
	var global_time = GlobalTimer.elapsed_time
	var player: AudioStreamPlayer2D = get_parent()
	var music_time = player.get_playback_position() * 1000
	print("Global timer is ahead by: %s" % (global_time - music_time))
	print("Elapsed 16ths: %s" % floor(GlobalTimer.elapsed_time / GlobalTimer.sixteenth_note_duration))
	print("Counted 16ths: %s" % GlobalTimer.total_sixteenth_notes)
	await(get_tree().create_timer(1).timeout)
	start()


func _on_button_pressed():
	get_parent().play()
	GlobalTimer.start()

