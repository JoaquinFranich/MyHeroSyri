class_name RigidBody2D_Enemy
extends RigidBody2D


@export var speed = Vector2()
#@export var hp = randf_range(50, 70)
@export var hp = 1
var time_scale := 1.0

func _physics_process(delta):
	var scaled_delta = delta * time_scale
	bounce()
	move(scaled_delta)
	global_position.y += -speed * scaled_delta
	
	
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


#func _on_body_entered(body):
	#if body is Player:
		#body.player_hit()
		#enemy_hit(1)


func _on_body_entered(body):
	if body is Player:
		body.player_hit()
		print("The player get hit!!!")
		enemy_hit(1)

func set_time_scale(scale: float):
	time_scale = scale

func _ready():
	add_to_group("gameplay")
