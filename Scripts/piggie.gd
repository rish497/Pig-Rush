extends CharacterBody2D
@onready var message_label: Label = $CanvasLayer/Label
@onready var timer: Timer = $Timer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@export var speed: float = 150.0
@export var Climb_speed= 50
@export var jump_force: float = 400.0
@export var gravity: float = 1500.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var oink_1: AudioStreamPlayer = $"Oink 5"
@onready var oink_2: AudioStreamPlayer = $"Oink 6"
@onready var oink_3: AudioStreamPlayer = $"Oink 7"
@onready var oink_4: AudioStreamPlayer = $"Oink 8"
@onready var death: AudioStreamPlayer = $AudioStreamPlayer2
@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var error: AudioStreamPlayer = $Error
@onready var panel: Panel = $CanvasLayer/Panel
@onready var button: Button = $"CanvasLayer/Panel/BuyNow!"
@onready var money_sound_2: AudioStreamPlayer = $MoneySound2
var on_ladder : bool
var climbing:bool
var can_move := true
var last_x_position: float
var pixel_accumulator: float = 0.0

@export var pixels_per_money := 8

var sound_pool: Array[AudioStreamPlayer] = []

func _ready():
	position = %RespawnPoint.position
	randomize()
	sound_pool = [oink_1,oink_2,oink_3,oink_4]
	start_random_timer()
	if GameManager.gift_claimed ==false:
		panel.visible = true
		panel.scale = Vector2(0.0, 0.0)
		animate_panel_in()
	
func animate_panel_in():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_interval(1)
	tween.tween_property(panel, "scale", Vector2(1.1, 1.1), 0.35)
	tween.tween_property(panel, "scale", Vector2(0.95, 0.95), 0.15)
	tween.tween_property(panel, "scale", Vector2(1.0, 1.0), 0.1)

func _on_buy_now_pressed() -> void:
	GameManager.add_money_smooth(1000)
	money_sound_2.play()
	GameManager.gift_claimed = true
	panel.visible = false
	
func _on_timer_timeout():
	play_random_sound()
	start_random_timer()

func start_random_timer():
	var random_time = randf_range(7.0, 10.0) 
	timer.wait_time = random_time
	timer.start()

func play_random_sound():
	var player = sound_pool.pick_random()
	player.play()

func _physics_process(delta: float) -> void:
	if not can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	var direction := 0.0
	if GameManager.money > 0:
		direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		velocity.x = direction * speed
	elif GameManager.money ==0:
		velocity.x = 0
	if GameManager.money == 0 and (	Input.is_action_just_pressed("ui_right") or	Input.is_action_just_pressed("ui_left")):
		error.play()
		show_message("Not enough money to walk")

	if is_on_floor() and velocity.x != 0:
		if not audio_stream_player.playing:
			audio_stream_player.play()
	else:
		audio_stream_player.stop()

	if GameManager.money > 0 and Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_force
		jump_sound.pitch_scale = randf_range(0.9, 1.1)
		jump_sound.play()
	elif Input.is_action_just_pressed("ui_up") and is_on_floor():
		show_message("Not enough money to jump")
		error.play()
	move_and_slide()
	handle_movement_money()
	update_animation(direction)
	if on_ladder:
		var vertical_dir = Input.get_axis("ui_up","ui_down")
		if GameManager.money > 0:
			if vertical_dir:
				velocity.y = vertical_dir * Climb_speed
				climbing = true
			else:
				velocity.y = move_toward(velocity.y, 0, Climb_speed)
				if is_on_floor(): climbing=false
			if climbing:
				if vertical_dir: sprite.play("Climb")
				else: sprite.pause()
		elif is_on_floor() == false:
			velocity += get_gravity() * delta
		if GameManager.money <= 0:
			show_message("Not enough money to climb")
		move_and_slide()
func show_message(text: String):
	message_label.text = text
	message_label.visible = true
	message_label.modulate.a = 1.0
	message_label.position.x = 0
	
	if message_label.has_meta("tween"):
		message_label.get_meta("tween").kill()

	var tween = create_tween()
	message_label.set_meta("tween", tween)

	tween.tween_property(message_label, "position:x", -10, 0.05)
	tween.tween_property(message_label, "position:x", 10, 0.05)
	tween.tween_property(message_label, "position:x", -6, 0.05)
	tween.tween_property(message_label, "position:x", 6, 0.05)
	tween.tween_property(message_label, "position:x", 0, 0.05)

	tween.tween_interval(0.8)

	tween.tween_property(message_label, "modulate:a", 0.0, 0.4)


func handle_movement_money():
	var current_x = global_position.x
	var delta_x = abs(current_x - last_x_position)

	if velocity.x != 0:
		pixel_accumulator += delta_x

		while pixel_accumulator >= pixels_per_money:
			if GameManager.money > 0:
				GameManager.money -= GameManager.walking_value
				pixel_accumulator -= pixels_per_money
			else:
				pixel_accumulator = 0
				break

	last_x_position = current_x


func update_animation(direction: float) -> void:
	if direction != 0:
		sprite.play("Walking")
		sprite.flip_h = direction < 0
	else:
		sprite.play("Idle")

func killplayer():
	can_move = false
	death.play()
	await get_tree().create_timer(1).timeout
	Engine.time_scale = 0.85
	velocity = Vector2.ZERO
	global_position = %RespawnPoint.global_position
	await get_tree().create_timer(0.1).timeout
	can_move = true


func _on_death_zone_body_entered(body: Node2D) -> void:
	if body != self:
		return
	if global_position.y < 100: 
		return
	Engine.time_scale = .85
	killplayer()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	on_ladder = true

 
func _on_area_2d_body_exited(body: Node2D) -> void:
	on_ladder = false
	sprite.play("Idle")
