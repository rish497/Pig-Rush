extends CharacterBody2D
@onready var timer: Timer = $Timer

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@export var speed: float = 150.0
@export var jump_force: float = 400.0
@export var gravity: float = 1500.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var oink_1: AudioStreamPlayer = $"Oink 5"
@onready var oink_2: AudioStreamPlayer = $"Oink 6"
@onready var oink_3: AudioStreamPlayer = $"Oink 7"
@onready var oink_4: AudioStreamPlayer = $"Oink 8"
@onready var death: AudioStreamPlayer = $AudioStreamPlayer2
@onready var jump_sound: AudioStreamPlayer = $JumpSound

var sound_pool: Array[AudioStreamPlayer] = []

func _ready():
	randomize()
	sound_pool = [oink_1,oink_2,oink_3,oink_4]
	start_random_timer()

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

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	var direction := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed
	if is_on_floor() and velocity.x != 0:
		if not audio_stream_player.playing:
			audio_stream_player.play()
	else:
		audio_stream_player.stop()

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_force
		jump_sound.pitch_scale = randf_range(0.9, 1.1)
		jump_sound.play()

	move_and_slide()

	update_animation(direction)


func update_animation(direction: float) -> void:
	if direction != 0:
		sprite.play("Walking")
		sprite.flip_h = direction < 0
	else:
		sprite.play("Idle")

func killplayer():
	death.play()
	position = %RespawnPoint.position
	$AnimatedSprite2D.flip_h=false



func _on_death_zone_body_entered(body: Node2D) -> void:
	Engine.time_scale = 0.7
	timer.start()
	killplayer()
