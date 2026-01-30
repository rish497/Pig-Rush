extends Control
@onready var control: Control = $"."

@onready var label: Label = $Panel/Label
@onready var voice_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var button: Button = $Panel/Button
@onready var movement: Node2D = $Movement
@onready var ladder: Node2D = $Ladder
@onready var pig: Label = $Pig
@onready var shop: Sprite2D = $Shop
@onready var heart: Label = $Heart

var generator := AudioStreamGenerator.new()
var playback: AudioStreamGeneratorPlayback

var sample_rate := 44100
var text_speed := .04

func _ready():
	if GameManager.tutorial == false:
		label.text= "Next"
		generator.mix_rate = sample_rate
		voice_player.stream = generator
		voice_player.play()
		playback = voice_player.get_stream_playback()

		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		type_writer("Hi " + GameManager.player_name + "! Welcome to Pig Panic!")
		await button.pressed

		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		type_writer("I just got to know that the pigs from the barn have escaped!")
		await button.pressed

		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		type_writer("You must collect them quickly or you will be the butcher's lunch tonight!!")
		await button.pressed

		label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
		type_writer("To move use the WASD keys or Arrow Keys.")
		movement.visible = true
		await button.pressed
		movement.visible = false

		label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
		type_writer("In the game you can climb ladders using Space, W, or the Up Arrow.")
		ladder.visible = true
		await button.pressed
		ladder.visible = false

		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		type_writer("Beware! Do not waste steps as walking costs money, so move wisely!")
		await button.pressed

		label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
		type_writer("To earn money you have to collect pigs.")
		pig.visible = true
		await button.pressed
		pig.visible = false

		label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
		type_writer("Sell pigs at the Butcher's Shop.")
		shop.visible = true
		await button.pressed
		shop.visible = false

		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		type_writer("Use the Shop button on the side of your screen to buy upgrades and potions to help you on this mission!")
		await button.pressed

		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		type_writer("You start with 6 lives.")
		await button.pressed

		label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
		type_writer("Extra lives are scattered around the map.")
		heart.visible = true
		await button.pressed
		heart.visible = false

		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		type_writer("You have to make as much money as you can before dying.")
		await button.pressed

		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		type_writer("Collect the money and...")
		await button.pressed

		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		type_writer("... climb the leaderboard!")
		await button.pressed

		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		type_writer("Good luck, and oink responsibly!")
		button.text = "Finish"
		await button.pressed
		control.visible = false
		GameManager.tutorial = true


func type_writer(text: String):
	button.visible = false
	label.visible = true

	label.text = text
	label.visible_characters = 0

	for i in text.length():
		label.visible_characters += 1
		play_pig_sound(text[i])
		await get_tree().create_timer(text_speed).timeout

	button.visible = true

func play_pig_sound(char: String):
	if char == " ":
		return

	var base_freq := 180.0 
	if char.to_lower() in ["a", "e", "i"]:
		base_freq = 220
	elif char.to_lower() in ["o", "u"]:
		base_freq = 160
	elif char in [".", "!", "?"]:
		base_freq = 120
	base_freq += randf_range(-15, 15)
	play_blip(base_freq, 0.05)
	
func play_blip(freq: float, duration: float):
	var frames := int(sample_rate * duration)
	var increment := TAU * freq / sample_rate
	var phase := 0.0

	for i in frames:
		var sample := sin(phase) * 1.4
		playback.push_frame(Vector2(sample, sample))
		phase += increment

	
