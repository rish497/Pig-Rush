extends Control
var ldboard_name = "main"
@onready var player_name = GameManager.player_name
@onready var line_edit: LineEdit = $Panel/LineEdit
var score = int(GameManager.score)
@onready var control: Control = $"."
@onready var panel_2: Panel = $Panel/Panel2
@onready var label: Label = $Panel/Label
func _ready() -> void:
	panel_2.visible = false
	label.visible = false
func _on_button_pressed() -> void:
	GameManager.play_button_click()
	panel_2.visible = true
	label.visible = true
	await get_tree().create_timer(1).timeout
	control.visible = false
	GameManager.profile_made = true
	await get_tree().create_timer(.3).timeout
	get_tree().change_scene_to_file("res://Scenes/Main Game.tscn")
	GameManager.timer_start()

	
func _on_line_edit_text_changed(new_text: String) -> void:
	GameManager.player_name = line_edit.text
