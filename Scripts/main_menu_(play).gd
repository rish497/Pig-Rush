extends Control

@onready var exit: Button = $"CanvasLayer/About/BuyNow!"
@onready var color_rect_2: ColorRect = $ColorRect2
@onready var about: Panel = $CanvasLayer/About
@onready var InputId: Control = $Control
@onready var credits: Panel = $CanvasLayer/Credits
@onready var xoutt: Button = $CanvasLayer/Credits/Xoutt
@onready var control: Control = $Control
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	GameManager.play_music()
	about.scale = Vector2(0.0, 0.0)
	await get_tree().process_frame
	reveal_from_black(2)

func animate_panel_in(panel):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(panel, "scale", Vector2(1, 1), 0.6)
	
func animate_panel_out(panel):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(panel, "scale", Vector2(0, 0), 0.6)

	
func _on_button_pressed() -> void:
	GameManager.mainmenustargame()
	if GameManager.profile_made == false:
		InputId.visible = true
	else:
		get_tree().change_scene_to_file("res://Scenes/Main Game.tscn")
		GameManager.timer_start()


func _on_button_2_pressed() -> void:
	GameManager.play_button_click()
	get_tree().quit()

func _on_button_3_pressed() -> void:
	GameManager.play_button_click()
	about.visible = true
	animate_panel_in(about)

func _on_xout_pressed() -> void:
	GameManager.play_button_click()
	animate_panel_out(about)
	await  get_tree().create_timer(0.2).timeout
	about.visible = false

func reveal_from_black(duration: float = 1.0) -> void:
	var screen_height = get_viewport_rect().size.y
	color_rect_2.position = Vector2(0, 0)
	color_rect_2.visible = true
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(color_rect_2,"position:y",screen_height,duration)
	await tween.finished
	color_rect_2.visible = false


func _on_button_4_pressed() -> void:
	GameManager.play_button_click()
	credits.visible = true
	animate_panel_in(credits)


func _on_xoutt_pressed() -> void:
	GameManager.play_button_click()
	animate_panel_out(credits)
	await  get_tree().create_timer(0.2).timeout
	credits.visible = false
