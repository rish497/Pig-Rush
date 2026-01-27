extends Node

var pig = 0
var money = 1000000
var arrow = load("res://Assets/Pointer3.png")
var pig_value = 100
var walking_value = 8
var collect_sound = false
var TP_to_sell = false
var Sell_at_spot = false
var cheap_walking = false
var walking_free = false
var twointo = false
@onready var button_click: AudioStreamPlayer = $ButtonClick
@onready var music: AudioStreamPlayer = $Music
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var gift_claimed := false
@onready var collect: AudioStreamPlayer = $AudioStreamPlayer

func play_button_click():
	if button_click.playing:
		button_click.stop()
	button_click.play()
	
func _ready():
	Input.set_custom_mouse_cursor(arrow)
	if collect_sound == true:
		collect.play()
		await collect.finished
		collect_sound = false

func play_music():
	if not music.playing:
		music.play()
		
func stop_music():
	music.stop()

func add_money_smooth(amount: int):
	var start_value = GameManager.money
	var end_value = start_value + amount

	var tween = get_tree().create_tween()
	tween.tween_method(
		func(value):
			GameManager.money = int(value),
		start_value,
		end_value,
		0.3 
	)
	
func loose_money_smooth(amount: int):
	var start_value = GameManager.money
	var end_value = start_value - amount

	var tween = get_tree().create_tween()
	tween.tween_method(
		func(value):
			GameManager.money = int(value),
		start_value,
		end_value,
		0.3 
	)

	


	
	
