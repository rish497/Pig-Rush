extends Node

var pig = 0
var score = 0
var arrow = load("res://Assets/cursor (2) (1).png")
var beam = load("res://Assets/tap (1).png")


func _ready():
	# Changes only the arrow shape of the cursor.
	# This is similar to changing it in the project settings.
	Input.set_custom_mouse_cursor(arrow)

	# Changes a specific shape of the cursor (here, the I-beam shape).
	Input.set_custom_mouse_cursor(beam, Input.CURSOR_POINTING_HAND)
