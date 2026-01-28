extends Panel
@onready var label_3: ColorRect = $ColorRect
@export var itemname: String
@export var itemimage: Texture2D
@export var itemprice: String
@export var itemdescription: String
@onready var label_4: ColorRect = $ColorRect2


func _ready():
	$Label.text = itemname
	$TextureRect.texture = itemimage
	$PanelContainer/HBoxContainer/Label.text = itemprice
	$Label2.text = itemdescription
	
func _process(delta: float) -> void:
	if GameManager.walking_free == false:
		label_4.visible = false
	elif GameManager.money < int(itemprice):
		label_3.visible = true
	else:
		label_3.visible = false
		
		

func _on_button_pressed() -> void:
	GameManager.play_button_click()
	label_4.visible = true
	if GameManager.money>=int(itemprice):
		GameManager.loose_money_smooth(int(itemprice))
		if itemname == "Walking is free (5min)":
			GameManager.walking_free = true
			GameManager.walking_value = 0
		elif itemname == "2x Everything (5min)":
			GameManager.twointo = true
	else:
		pass
		
			

	
		
