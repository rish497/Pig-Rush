extends CharacterBody2D
@onready var timer: Timer = $"../DeathZone/Timer"

@export var speed: float = 150.0
@export var jump_force: float = 400.0
@export var gravity: float = 1500.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	var direction := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_force
		

	move_and_slide()

	update_animation(direction)


func update_animation(direction: float) -> void:
	if direction != 0:
		sprite.play("Walking")
		sprite.flip_h = direction < 0
	else:
		sprite.play("Idle")

func killplayer():
	position = %RespawnPoint.position
	$AnimatedSprite2D.flip_h=false



func _on_death_zone_body_entered(body: Node2D) -> void:
	Engine.time_scale = 0.7
	timer.start()
	killplayer()
