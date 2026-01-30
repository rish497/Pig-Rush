extends Control

@onready var Total_Money: Label = $Panel/HBoxContainer/VBoxContainer2/Label
@onready var Pig_Caught: Label = $Panel/HBoxContainer/VBoxContainer2/Label2
@onready var Time_survived: Label = $Panel/HBoxContainer/VBoxContainer2/Label3

@onready var Money_All_Time: Label = $Panel/HBoxContainer/VBoxContainer3/Label
@onready var Pig_All_Time: Label = $Panel/HBoxContainer/VBoxContainer3/Label2
@onready var Time_All_Time: Label = $Panel/HBoxContainer/VBoxContainer3/Label3
@onready var button: Button = $Button

func _ready():
	visible = false

func _process(delta: float) -> void:
	if GameManager.health == 0:
		show_death_screen()

		
func show_death_screen():
	GameManager.update_best_stats()
	update_ui()


func update_ui():
	Total_Money.text = str(GameManager.money)
	Pig_Caught.text = str(GameManager.pig)
	Time_survived.text = format_time(GameManager.run_time)

	Money_All_Time.text = str(GameManager.best_money)
	Pig_All_Time.text = str(GameManager.best_pigs)
	Time_All_Time.text = format_time(GameManager.best_time)


func format_time(seconds: float) -> String:
	var total_seconds := int(seconds)
	var minutes := total_seconds / 60
	var secs := total_seconds % 60
	return "%02d:%02d" % [minutes, secs]


func _on_button_pressed() -> void:
	GameManager.play_button_click()
	GameManager.reset_run()
	get_tree().change_scene_to_file("res://Scenes/Main Menu (Play).tscn")
