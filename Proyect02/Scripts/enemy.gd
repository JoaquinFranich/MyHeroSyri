class_name Enemy
extends Area2D

@export var speed = Vector2()
@export var hp = randf_range(2, 5)

var time_scale := 1.0

func set_time_scale(scale: float):
	time_scale = scale

func _ready():
	add_to_group("gameplay")

func _physics_process(delta):
	var scaled_delta = delta * time_scale
	bounce()
	move(scaled_delta)
	
	#var direction = global_position.direction_to(Player.global_position)
	#var velocity = direction * speed
	
	
# Rebote del Virus
func bounce():
	var flag = false
	var speedX = 0.0

	while not flag:
		speedX = randf_range(-500, 500)
		if speedX < -1 or speedX > 1:
			flag = true
 
	speed = Vector2(speedX, randf_range(-500, 500))


# Movimiento del Virus
func move(delta):
	position += speed * delta


# Colision
func enemy_hit(amount):
	hp -= amount
	if hp <= 0:
		queue_free()


func _on_body_entered(body):
	if body is Player:
		body.player_hit()
		enemy_hit(1)
