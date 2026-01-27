extends Panel
@onready var label_3: Label = $Label3
@export var itemname: String
@export var itemimage: Texture2D
@export var itemprice: String
@export var itemdescription: String
@onready var label_4: Label = $Label4

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
	if GameManager.money>=int(itemprice):
		GameManager.loose_money_smooth(int(itemprice))
		label_4.visible = true
		if itemname == "T.P. TO SELL":
			GameManager.TP_to_sell = true
		elif itemname == "SELL AT SPOT":
			GameManager.Sell_at_spot = true
		elif itemname == "Cheap Walking":
			GameManager.cheap_walking = true
			GameManager.walking_value = 4
		elif itemname == "Walking is free (5min)":
			GameManager.walking_free = true
		elif itemname == "2x Everything (5min)":
			GameManager.twointo = true
	else:
		pass
	
		
	
	
		
