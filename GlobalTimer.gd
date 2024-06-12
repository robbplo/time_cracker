extends Node

signal started
signal quarter_note(index: int)
signal sixteenth_note(index: int)

@export var bpm = 112
## Duration of a quarter note in milliseconds
var quarter_note_duration: int = floor(60.0 / bpm * 1000)
## Duration of a sixteenth note in milliseconds
var sixteenth_note_duration: int = floor(quarter_note_duration / 4.0)

## In milliseconds
var start_time: int = 0
## In milliseconds
var elapsed_time: int = 0

# amount of notes
var total_quarter_notes: int = 0
var total_sixteenth_notes: int = 0

func _ready():
	start_time = Time.get_ticks_msec()
	started.emit()

func _process(delta):
	var delta_ms = floor(delta * 1000)
	elapsed_time = Time.get_ticks_msec() - start_time
	if (elapsed_time % quarter_note_duration) < delta_ms:
		quarter_note.emit(total_quarter_notes % 4)
		total_quarter_notes += 1
	if (elapsed_time % sixteenth_note_duration) < delta_ms:
		sixteenth_note.emit(total_sixteenth_notes % 16)
		total_sixteenth_notes += 1

func is_on_time(_ms: int):
	return true
