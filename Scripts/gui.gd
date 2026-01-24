extends CanvasLayer

func _process(delta: float) -> void:
	$"pig value".text = str(GameManager.pig)
	$"Money Value".text = str(GameManager.money)
