extends Area2D
@onready var button: Button = $Button
var player_inside = false
@onready var money_sound: AudioStreamPlayer = $MoneySound

func _on_button_pressed() -> void:
	GameManager.play_button_click()
	sold()

func _on_body_exited(body: Node2D) -> void:
	button.visible = false
	player_inside = false

func _on_body_entered(body: Node2D) -> void:
	button.visible = true
	player_inside = true
	
func _process(delta):
	if player_inside and Input.is_action_just_pressed("E"):
		GameManager.play_button_click()
		sold()

func add_money_smooth(amount: int):
	var start_value = GameManager.money
	var end_value = start_value + amount

	var tween = get_tree().create_tween()
	tween.tween_method(
		func(value):
			GameManager.money = int(value),
		start_value,
		end_value,
		0.3 # duration (fast)
	)
func sold():
	
	if GameManager.pig == 0:
		print("No Pigs available")
	else:
		print("Pigs Sold!")
		money_sound.play()
		add_money_smooth(GameManager.pig * 100)
		GameManager.pig = 0
			


	



	
