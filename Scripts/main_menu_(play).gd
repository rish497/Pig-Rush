extends Control
@onready var about: Panel = $CanvasLayer/About
@onready var exit: Button = $"CanvasLayer/About/BuyNow!"


func _ready() -> void:
	GameManager.play_music()
	about.scale = Vector2(0.0, 0.0)
	

func animate_panel_in():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(about, "scale", Vector2(1, 1), 0.6)
	
func animate_panel_out():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(about, "scale", Vector2(0, 0), 0.6)
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main Game.tscn")
	GameManager.play_button_click()

func _on_button_2_pressed() -> void:
	GameManager.play_button_click()
	get_tree().quit()

func _on_button_3_pressed() -> void:
	about.visible = true
	animate_panel_in()

func _on_xout_pressed() -> void:
	animate_panel_out()
	await  get_tree().create_timer(0.2).timeout
	about.visible = false
