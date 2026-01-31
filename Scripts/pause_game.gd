extends Control
@onready var control: Control = $"."


func _on_play_pressed() -> void:
	GameManager.play_button_click()
	control.visible = false
	control.scale=Vector2(0,0)


func _on_main_menu_pressed() -> void:
	GameManager.play_button_click()
	get_tree().change_scene_to_file("res://Scenes/Main Menu (Play).tscn")


func _on_kill_player_pressed() -> void:
	GameManager.play_button_click()
	GameManager.health =0
