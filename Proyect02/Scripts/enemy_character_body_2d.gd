class_name Enemy_character_body_2D 
extends CharacterBody2D

signal killed(points)

@onready var player = get_node("/root/Game/Gameplay/Player")

@export var speed = Vector2()
@export var enemy_hp = randf_range(3, 5)
@export var points = randf_range(50, 150)

var time_scale := 1.0

func set_time_scale(scale: float):
	time_scale = scale
	print("Enemy time_scale set to: ", scale)  # Debug output

func _ready():
	add_to_group("gameplay")

func _process(delta):
	pass

func _physics_process(delta):
	var scaled_delta = delta * time_scale
	bounce()
	move(scaled_delta)
	follow_player(scaled_delta)
	
	
# Rebote del Virus
func bounce():
	var flag = false
	var speedX = 0.0

	while not flag:
		speedX = randf_range(-300, 300)
		if speedX < -1 or speedX > 1:
			flag = true
 
	speed = Vector2(speedX, randf_range(-300, 300))


# Movimiento del Virus
func move(delta):
	position += speed * delta


# Perseguir al Player
func follow_player(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 25.0
	move_and_slide()


# Puntos
func enemy_killed():
	#print(enemy_hp)
	#if enemy_hp <= 2:
		#points = 100
		#killed.emit(points)
	#else:
		#points = 200
		#killed.emit(points)
	killed.emit(points)
	queue_free()
	
# Colision
func enemy_hit(amount):
	enemy_hp -= amount
	if enemy_hp <= 0:
		enemy_killed()

