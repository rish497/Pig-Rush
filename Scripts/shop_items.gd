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
	if GameManager.money >= int(itemprice):
		label_3.visible = false
	else:
		label_3.visible = true
		
		

func _on_button_pressed() -> void:
	GameManager.play_button_click()
	if GameManager.money>=int(itemprice):
		GameManager.loose_money_smooth(int(itemprice))
		label_4.visible = true
		if itemname == "T.P. TO SELL":
			GameManager.TP_to_sell = true
		elif itemname == "SELL AT SPOT":
			GameManager.Sell_at_spot = true
		elif itemname == "Cheap Walking":
			GameManager.cheap_walking = true
			GameManager.walking_value = .5
		elif itemname == "Valuable Pigs":
			GameManager.pig_value = 200
		elif itemname == "Walking is free (5min)":
			GameManager.walking_free = true
			GameManager.walking_value = 0
		elif itemname == "2x Everything (5min)":
			GameManager.twointo = true
	else:
		pass
		
			

	
		
