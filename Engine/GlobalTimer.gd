extends Node

signal started
signal quarter_note(index: int)
signal sixteenth_note(index: int)

var running = false
@export var bpm = 112
## Duration of a quarter note in milliseconds
var quarter_note_duration: float = 60.0 / bpm * 1000
## Duration of a sixteenth note in milliseconds
var sixteenth_note_duration: float = quarter_note_duration / 4.0

## In milliseconds
var start_time: float = 0
## In milliseconds
var elapsed_time: float = 0
## Amount of quarter notes since starting
var total_quarter_notes: int = 0
## Amount of sixteenth notes since starting
var total_sixteenth_notes: int = 0
## In seconds
@onready var output_latency: float = AudioServer.get_output_latency()
@onready var player: AudioStreamPlayer = get_tree().root.get_child(-1).find_child("Song")


func _ready():
	player.play()
	start()

func _process(_delta):
	if not running:
		return

	get_tree().get_frame()
	elapsed_time = player.get_playback_position()
	elapsed_time += AudioServer.get_time_since_last_mix()
	elapsed_time -= output_latency
	elapsed_time *= 1000.0

	var new_quarter_notes = floor(elapsed_time / quarter_note_duration)
	if new_quarter_notes > total_quarter_notes:
		_add_quarter_note()

	var new_sixteenth_notes = floor(elapsed_time / sixteenth_note_duration)
	if new_sixteenth_notes > total_sixteenth_notes:
		_add_sixteenth_note()

func start():
	running = true
	started.emit()
	_add_quarter_note()
	_add_sixteenth_note()

func _add_quarter_note():
	total_quarter_notes += 1
	quarter_note.emit(total_quarter_notes % 4)

func _add_sixteenth_note():
	total_sixteenth_notes += 1
	sixteenth_note.emit(total_sixteenth_notes % 16)

func is_on_time(_n):
	return true
