extends Area2D
var delta = -1
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: CharacterBody2D):
		GameManager.pig +=1
		GameManager.pigcollectsound()
		queue_free()


	
