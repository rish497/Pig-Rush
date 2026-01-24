extends Control

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var fade: CanvasLayer = $fade

func _ready() -> void:
	
	sprite.play("Loading Screen")
	await get_tree().create_timer(10.0).timeout
	sprite.play("Gamecube")
	await sprite.animation_finished
	
	sprite.play("Godot")
	await sprite.animation_finished
	await get_tree().create_timer(2.0).timeout
	
	await fade.fade(1.0, 1.5).finished
	await fade.fade(-1.0, 1.5).finished
	get_tree().change_scene_to_file("res://Scenes/Main Menu (Play).tscn")
