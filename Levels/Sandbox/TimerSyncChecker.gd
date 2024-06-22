extends Node
class_name TimerSyncChecker

func _ready():
	start()

func start():
	var global_time = GlobalTimer.elapsed_time
	var player: AudioStreamPlayer2D = get_parent()
	var music_time = player.get_playback_position()
	print("Global timer is ahead by: %s" % (global_time - music_time))
	print("Elapsed 16ths: %s" % floor(GlobalTimer.elapsed_time / GlobalTimer.sixteenth_note_duration))
	print("Counted 16ths: %s" % GlobalTimer.total_sixteenth_notes)
	print("Elapsed 4ths: %s" % floor(GlobalTimer.elapsed_time / GlobalTimer.quarter_note_duration))
	print("Counted 4ths: %s" % GlobalTimer.total_quarter_notes)
	print("Counted 16ths mod 4: %s" % floor(GlobalTimer.total_sixteenth_notes / 4))

	await(get_tree().create_timer(1).timeout)
	start()


func _on_button_pressed():
	get_parent().play()
	GlobalTimer.start()

