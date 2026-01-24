extends Area2D
var delta = -1

func _on_body_entered(body: Node2D):
		GameManager.pig +=1
		queue_free()
