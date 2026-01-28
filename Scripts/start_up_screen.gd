extends Control

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var fade: CanvasLayer = $fade
@onready var SOUND_1: AudioStreamPlayer = $SOUND1
@onready var SOUND_2: AudioStreamPlayer = $SOUND2
@onready var SOUND_3: AudioStreamPlayer = $SOUND3
@onready var label: Label = $Label2
@onready var label1: Label = $Label
@onready var color_rect: ColorRect = $ColorRect2

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	sprite.scale = Vector2(1,1)
	color_rect.color = Color("#030303")
	label.visible = true
	sprite.play("Loading Screen")
	SOUND_1.play()
	await get_tree().create_timer(6.0).timeout
	label.visible = false
	SOUND_1.stop()
	
	sprite.scale = Vector2(2,2)
	color_rect.color = Color("#000000")
	label1.visible = true
	sprite.play("Gamecube")
	SOUND_2.play()
	await sprite.animation_finished
	await get_tree().create_timer(1.5).timeout
	SOUND_2.stop()
	
	sprite.scale = Vector2(1,1)
	sprite.play("Godot")
	SOUND_3.play()
	await sprite.animation_finished
	await get_tree().create_timer(2.0).timeout
	SOUND_3.stop()
	
	await fade.fade(1.0, 1.5).finished
	get_tree().change_scene_to_file("res://Scenes/Main Menu (Play).tscn")
