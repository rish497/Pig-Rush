extends Area2D
@onready var button: Button = $Button
var player_inside := false

func _ready():
	button.visible = false
	player_inside = false

func _on_button_pressed() -> void:
	sold()
	
func _on_body_exited(body: Node2D) -> void:
	button.visible = false
	player_inside = false

func _on_body_entered(body: Node2D) -> void:
	button.visible = true
	player_inside = true
	
func _process(delta):
	if player_inside and Input.is_action_just_pressed("E"):
		sold()

func sold():
	if GameManager.pig == 0:
		print("No Pigs available")
	else:
		print("Pigs Sold!")
		GameManager.money = GameManager.pig * 100
		GameManager.pig = 0
			


	
