extends AnimatedSprite2D
@onready var heal_collected: AudioStreamPlayer = $HealCollected


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Piggie":
		GameManager.healthcollected()
		GameManager.health +=1
		queue_free()
