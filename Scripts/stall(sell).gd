extends Area2D
@onready var timer: Timer = $Timer
@onready var message_label: Label = $CanvasLayer/Label
@onready var button: Button = $Button
var player_inside = false
@onready var money_sound: AudioStreamPlayer = $MoneySound
@onready var error_2: AudioStreamPlayer = $Error2

func _on_button_pressed() -> void:
	GameManager.play_button_click()
	sold()

func _on_body_exited(body: Node2D) -> void:
	button.visible = false
	player_inside = false
	message_label.visible = false

func _on_body_entered(body: Node2D) -> void:
	button.visible = true
	player_inside = true
	show_message_permanent("Press [E] to Sell")
	
func _process(delta):
	if player_inside and Input.is_action_just_pressed("E"):
		GameManager.play_button_click()
		sold()


func sold():
	
	if GameManager.pig == 0:
		show_message("No more bacon left to sell!")
		error_2.play()
	else:
		show_message("Pigs Sold!")
		money_sound.play()
		GameManager.add_money_smooth(GameManager.pig * GameManager.pig_value)
		GameManager.pig = 0
		
func show_message_permanent(text:String):
	message_label.text = text
	message_label.visible = true
	message_label.modulate.a = 1.0
	message_label.position.x = 0
	var tween = create_tween()
	message_label.set_meta("tween", tween)
	tween.tween_property(message_label, "position:x", 10, 0.05)
	
func show_message(text: String):
	message_label.text = text
	message_label.visible = true
	message_label.modulate.a = 1.0
	message_label.position.x = 0
	
	
	if message_label.has_meta("tween"):
		message_label.get_meta("tween").kill()

	var tween = create_tween()
	message_label.set_meta("tween", tween)

	tween.tween_property(message_label, "position:x", -10, 0.05)
	tween.tween_property(message_label, "position:x", 10, 0.05)
	tween.tween_property(message_label, "position:x", -6, 0.05)
	tween.tween_property(message_label, "position:x", 6, 0.05)
	tween.tween_property(message_label, "position:x", 0, 0.05)

	tween.tween_interval(0.8)

	tween.tween_property(message_label, "modulate:a", 0.0, 0.4)

			


	



	
