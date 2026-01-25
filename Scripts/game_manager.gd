extends Node

var pig = 0
var money = 0
var arrow = load("res://Assets/cursor (2) (1).png")
var beam = load("res://Assets/tap (1).png")
@onready var button_click: AudioStreamPlayer = $ButtonClick
@onready var music: AudioStreamPlayer = $Music
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func play_button_click():
	if button_click.playing:
		button_click.stop()
	button_click.play()
	
func _ready():
	Input.set_custom_mouse_cursor(arrow)
	Input.set_custom_mouse_cursor(beam, Input.CURSOR_POINTING_HAND)

func play_music():
	if not music.playing:
		music.play()
		
func stop_music():
	music.stop()
