extends Control
@onready var scroll: ScrollContainer = $ShopPanel/VBoxContainer/HBoxContainer/ScrollContainer
@onready var content: VBoxContainer = $ShopPanel/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer
		
func scroll_to_item(item: Control):
	await get_tree().process_frame
	
	var target_y = item.global_position.y - content.global_position.y
	
	var tween = create_tween()
	tween.tween_property(scroll,"scroll_vertical",target_y,0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)


func _on_upgrade_pressed() -> void:
	GameManager.play_button_click()
	scroll_to_item($ShopPanel/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/Label)


func _on_potions_pressed() -> void:
	GameManager.play_button_click()
	scroll_to_item($ShopPanel/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/Label2)
