extends Control

@onready var volume_1: Sprite2D = $Volume1  # mute
@onready var volume_2: Sprite2D = $Volume2  # low
@onready var volume_3: Sprite2D = $Volume3  # mid
@onready var volume_4: Sprite2D = $Volume4  # high


func _ready() -> void:
	update_volume_icons()


func _on_button_pressed() -> void:
	GameManager.cycle_volume()
	update_volume_icons()
	print(GameManager.volume_level)


func update_volume_icons():
	volume_1.visible = false
	volume_2.visible = false
	volume_3.visible = false
	volume_4.visible = false

	match GameManager.volume_level:
		0:
			volume_1.visible = true
		1:
			volume_2.visible = true
		2:
			volume_3.visible = true
		3:
			volume_4.visible = true
