extends CanvasLayer
@onready var shop: Control = $SHOP
@onready var label: Label = $TPtoSell/Label
@onready var label1: Label = $SellAtSpot/Label


func _ready() -> void:
	shop.scale=Vector2(0,0)
	label.visible = true
	label1.visible = true
	
func _process(_delta: float) -> void:
	$"pig value".text = str(GameManager.pig)
	$"Money Value".text = str(GameManager.money)
	if GameManager.TP_to_sell == true:
		label.visible = false
	if GameManager.Sell_at_spot == true:
		label1.visible = false
		


func _on_shop_pressed() -> void:
	pop_in(shop)


func _on_pause_pressed() -> void:
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	pass # Replace with function body.

func pop_in(panel):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(panel, "scale", Vector2(1.0, 1.0), .6)


func _on_button_pressed() -> void:
	shop.scale=Vector2(0,0)
