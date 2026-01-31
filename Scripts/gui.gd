extends CanvasLayer
@onready var shop: Control = $Node/SHOP
@onready var label: TextureRect = $Node/TextureRect3
@onready var label1: TextureRect = $Node/TextureRect2
@onready var control: Control = $Node/Control
@onready var animated_sprite_2d: AnimatedSprite2D = $Node/AnimatedSprite2D
@onready var died: Panel = $Died/Panel
var death_ui_shown := false
@onready var death_label: Label = $Died/Panel/Label
@onready var ScoreBoard: Control = $Died/Control
@onready var leaderboard_2: Node2D = $Node/Leaderboard2

@onready var tutorial: Control = $Tutorial

func _ready() -> void:
	shop.scale = Vector2(0,0)
	label.visible = true
	label1.visible = true
	control.scale=Vector2(0,0)
	died.visible = false
	death_label.visible=false
	ScoreBoard.visible=false
	leaderboard_2.visible=false
	if GameManager.tutorial == false:
		await get_tree().create_timer(.2).timeout
		tutorial.visible = true
	else:
		tutorial.visible = false
	
func _process(_delta: float) -> void:
	if GameManager.health>0:
		death_ui_shown = false
		died.visible = false
		died.self_modulate.a = 0.0
	$Node/AnimatedSprite2D.play(str(GameManager.health))
	$"Node/pig value".text = str(GameManager.pig)
	$"Node/Money Value".text = str(int(GameManager.money))
	if GameManager.TP_to_sell == true:
		label.visible = false
	if GameManager.Sell_at_spot == true:
		label1.visible = false
	if GameManager.health == 0 and not death_ui_shown:
		death_label.visible=true
		death_ui_shown = true
		show_death_screen()
		death_label.visible=false
		animate_scoreboard()
		
func animate_scoreboard():
	ScoreBoard.visible = true
	ScoreBoard.scale = Vector2(0.0, 0.0)
	ScoreBoard.pivot_offset = ScoreBoard.size / 2

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(ScoreBoard,"scale",Vector2(1.0, 0.0),0.35)
	tween.tween_property(ScoreBoard,"scale",Vector2(1.0, 1.0),0.25)
	
func show_death_screen():
	died.visible = true
	died.self_modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(died, "self_modulate:a", 1.0, 0.6)

func _on_shop_pressed() -> void:
	GameManager.play_button_click()
	shop.visible = true
	pop_in(shop)
	

func _on_pause_pressed() -> void:
	GameManager.play_button_click()
	control.visible = true
	pop_in(control)


func pop_in(panel):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(panel, "scale", Vector2(1.0, 1.0), .6)

func _on_button_pressed() -> void:
	GameManager.play_button_click()
	shop.scale=Vector2(0,0)


func _on_leaderboard_pressed() -> void:
	leaderboard_2.visible = true
	await get_tree().process_frame
	leaderboard_2.call_deferred("refresh")


func _on_t_pto_sell_pressed() -> void:
	GameManager.play_button_click()
	GameManager.Tp_to_sell_pressed =true


func _on_sell_at_spot_pressed() -> void:
	GameManager.play_button_click()
	GameManager.Sell_at_spot_pressed = true
