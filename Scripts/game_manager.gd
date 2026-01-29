extends Node
signal walking_free_changed(value: bool)
var pig = 0
var money = 1000000
var arrow = load("res://Assets/Pointer3.png")
var pig_value = 100
var walking_value := 1
var collect_sound = false
var TP_to_sell = false
var Sell_at_spot = false
var cheap_walking = false
var walking_free := false:
	set(value):
		if walking_free == value:
			return
		walking_free = value
		walking_free_changed.emit(value)
var twointo = false
var gift_claimed := false
var default_walking_value := 1
var score = money
var player_name:String
var profile_made = false
@onready var button_click: AudioStreamPlayer = $ButtonClick
@onready var music: AudioStreamPlayer = $Music
@onready var collect: AudioStreamPlayer = $collect
var ldboard_name = "main"
var last_saved_score := -1

func play_button_click():
	if button_click.playing:
		button_click.stop()
	button_click.play()
	
func _ready():
	SilentWolf.configure({
		"api_key": "iXNVMVArkV22UrBQoZSU33u9Q0oODSG97KMhTnBH",
		"game_id": "PigPanic",
		"log_level": 1
		})
	SilentWolf.configure_scores({"open_scene_on_close": "res://scenes/MainPage.tscn"})

	Input.set_custom_mouse_cursor(arrow)


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

func _process(delta: float) -> void:
	score = money
	if collect_sound == true:
		collect.play()
		await collect.finished
		collect_sound = false
	if profile_made and score != last_saved_score:
		last_saved_score = score
		SilentWolf.Scores.save_score(player_name, score, ldboard_name)


func activate_walking_free():
	walking_free = false
	walking_free = true



	
	
