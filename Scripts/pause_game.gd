extends Control
@onready var control: Control = $"."


func _on_play_pressed() -> void:
	control.visible = false
	control.scale=Vector2(0,0)


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main Menu (Play).tscn")
