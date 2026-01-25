extends Control

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var fade: CanvasLayer = $fade
@onready var SOUND_1: AudioStreamPlayer = $SOUND1
@onready var SOUND_2: AudioStreamPlayer = $SOUND2
@onready var SOUND_3: AudioStreamPlayer = $SOUND3

func _ready() -> void:
	
	sprite.play("Loading Screen")
	SOUND_1.play()
	await get_tree().create_timer(10.0).timeout
	SOUND_1.stop()
	
	
	sprite.play("Gamecube")
	SOUND_2.play()
	await sprite.animation_finished
	await get_tree().create_timer(1.5).timeout
	SOUND_2.stop()
	
	sprite.play("Godot")
	SOUND_3.play()
	await sprite.animation_finished
	await get_tree().create_timer(2.0).timeout
	SOUND_3.stop()
	
	await fade.fade(1.0, 1.5).finished
	get_tree().change_scene_to_file("res://Scenes/Main Menu (Play).tscn")
