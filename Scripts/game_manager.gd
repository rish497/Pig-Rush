extends Node

var pig = 0
var money = 0
var arrow = load("res://Assets/cursor (2) (1).png")
var beam = load("res://Assets/tap (1).png")


func _ready():
	Input.set_custom_mouse_cursor(arrow)
	Input.set_custom_mouse_cursor(beam, Input.CURSOR_POINTING_HAND)
