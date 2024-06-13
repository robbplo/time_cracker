extends Node

signal started
signal quarter_note(index: int)
signal sixteenth_note(index: int)

var running = false
@export var bpm = 112
## Duration of a quarter note in milliseconds
var quarter_note_duration: int = floor(60.0 / bpm * 1000)
## Duration of a sixteenth note in milliseconds
var sixteenth_note_duration: int = floor(quarter_note_duration / 4.0)

## In microseconds
var start_time: float = 0
## In milliseconds
var elapsed_time: float = 0
## Amount of quarter notes since starting
var total_quarter_notes: int = 0
## Amount of sixteenth notes since starting
var total_sixteenth_notes: int = 0

var delay_time: float

func _ready():
	delay_time = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	$"/root/Sandbox/SongTenderCircuits".play()
	start()


func _process(_delta):
	if not running:
		return

	elapsed_time = (Time.get_ticks_usec() - start_time) / 1000.0
	elapsed_time -= delay_time
	elapsed_time = max(0, elapsed_time)

	var new_sixteenth_notes = int(elapsed_time / floor(sixteenth_note_duration))
	if new_sixteenth_notes > total_sixteenth_notes:
		sixteenth_note.emit(total_sixteenth_notes % 16)
		total_sixteenth_notes += 1

	var new_quarter_notes = int(elapsed_time / floor(quarter_note_duration))
	if new_quarter_notes > total_quarter_notes:
		quarter_note.emit(total_quarter_notes % 4)
		total_quarter_notes += 1
		print(total_quarter_notes)



func start():
	running = true
	start_time = Time.get_ticks_usec()
	#elapsed_time = start_time
	started.emit()
	quarter_note.emit(total_quarter_notes % 4)
	total_quarter_notes += 1
	sixteenth_note.emit(total_sixteenth_notes % 16)
	total_sixteenth_notes += 1

func is_on_time(_ms: int):
	return true


# var prev = 0
# func _physics_process(delta):
# 	if not running:
# 		return
# 	var delta_ms = floor(delta * 1000)
#
# 	prev = elapsed_time
# 	elapsed_time = $"/root/Sandbox/SongTenderCircuits".get_playback_position() * 1000.0
# 	#print((elapsed_time - prev), delta_ms)
# 	# elapsed_time = Time.get_ticks_msec() - start_time
#
# 	#var music_times = $"/root/Sandbox/SongTenderCircuits".get_playback_position() * 1000.0
# 	#var time_offset = elapsed_time - music_time
# 	#if time_offset > 3 * delta_ms
#
#
# 	print(elapsed_time / floor(quarter_note_duration))
# 	var new_quarter_notes = int(elapsed_time / floor(quarter_note_duration))
# 	if new_quarter_notes > total_quarter_notes:
# 		quarter_note.emit(total_quarter_notes % 4)
# 		total_quarter_notes += 1
#
# 	var new_sixteenth_notes = int(elapsed_time / floor(sixteenth_note_duration))
# 	if new_sixteenth_notes > total_sixteenth_notes:
# 		sixteenth_note.emit(total_sixteenth_notes % 16)
# 		total_sixteenth_notes += 1
#
# func start():
# 	running = true
# 	#start_time = Time.get_ticks_msec()
# 	#elapsed_time = start_time
# 	started.emit()
