extends Panel
@onready var panel: Panel = $"."

@onready var panel_2: Panel = $Panel2
@onready var timer: Timer = $Timer

@export var title: String
@export var image: Texture2D
@export var time_seconds: int = 120


var current_time: int

func _ready():
	panel_2.visible = false
	current_time = time_seconds

	$Panel2/Time.text = format_time(current_time)

	$TextureRect.texture = image
	$Panel2/Title.text = title

	timer.timeout.connect(_on_timer_timeout)
	GameManager.walking_free_changed.connect(_on_walking_free_changed)

	# sync in case walking_free was already true
	_on_walking_free_changed(GameManager.walking_free)


func start_countdown():
	current_time = time_seconds
	$Panel2/Time.text = format_time(current_time)
	timer.start()


func _on_timer_timeout():
	if current_time > 0:
		current_time -= 1
		$Panel2/Time.text = format_time(current_time)
	else:
		timer.stop()
		GameManager.walking_free = false
		if GameManager.cheap_walking == true:
			GameManager.walking_value = .5
		else:
			GameManager.walking_value = 1


func _on_walking_free_changed(value: bool) -> void:
	panel.visible = value

	if value:
		start_countdown()
	else:
		timer.stop()


func _on_mouse_entered() -> void:
	panel_2.visible = true


func _on_mouse_exited() -> void:
	panel_2.visible = false
	
func format_time(seconds: int) -> String:
	var minutes := seconds / 60
	var secs := seconds % 60
	return "%02d:%02d" % [minutes, secs]
