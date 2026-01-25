extends Control


func _ready() -> void:
	GameManager.play_music()
		
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main Game.tscn")
	GameManager.play_button_click()

func _on_button_2_pressed() -> void:
	GameManager.play_button_click()
	get_tree().quit()
	
