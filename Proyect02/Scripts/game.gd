class_name Game
extends Node2D

@export var enemy_scenes: Array[PackedScene] = []
@export var bullet_time_slowdown = 0.3 # Factor de relentizacion del tiempo

@onready var player_spawn_pos = $PlayerSpawnPos
@onready var bullet_conainer = $BulletContainer
#@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var hud = $UI_Layer/HUD
@onready var gameover = $UI_Layer/GameOverScreen

var player = null
var score := 0:
	set(value):
		score = value
		if score == value:
			hud.score = score
			$UI_Layer/HUD/Score/AnimationPlayer.play("POV")
	#set(value):
		#score = value
		#hud.score = score
		
var is_moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI_Layer/FadeTransition.show()
	$UI_Layer/FadeTransition/FadeTimer.start()
	$UI_Layer/FadeTransition/AnimationPlayer.play("fade_out")
	
	score = 0
	
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	player.global_position = player_spawn_pos.global_position
	player.bullet_shot.connect(_on_player_bullet_shot)
	player.hp_depleted.connect(_on_player_killed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _physics_process(delta):
	var dir = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	is_moving = dir.length() > 0
	
	# Ajustar Engine.time_scale segun el movimiento del jugador.
	if is_moving:
		Engine.time_scale = 1.0
	else:
		Engine.time_scale = bullet_time_slowdown
	# Movimiento del Jugador.
	#player.velocity = dir * player.speed
	#player.move_and_slide()
	
	# Movimiento de los Enemigos.
	#for enemy in enemy_container.get_children():
		#if enemy.has_method("_process"):
			#enemy._process(adjusted_delta)
		#if enemy.has_method("_physics_process"):
			#enemy.set_physics_process(adjusted_delta)
	#for enemy in enemy_container.get_children():
		#enemy.set_physics_process(is_moving)


func _on_player_bullet_shot(bullet_scene, location):
	var bullet = bullet_scene.instantiate()
	bullet.global_position= location
	bullet_conainer.add_child(bullet)


func _on_enemy_spawn_timer_timeout():
	if is_moving == true:
		for i in range(randf_range(7, 10)):
			var e = enemy_scenes.pick_random().instantiate()
			e.global_position = Vector2(randf_range(50, 300), randf_range(50, 90))
			e.killed.connect(_on_enemy_killed)
			enemy_container.add_child(e)
	#for i in range(randf_range(7, 10)):
		#var e = enemy_scenes.pick_random().instantiate()
		#e.global_position = Vector2(randf_range(50, 300), randf_range(50, 90))
		#e.killed.connect(_on_enemy_killed)
		#enemy_container.add_child(e)


func _on_enemy_killed(points):
	score += points
	print("You sum ", points, ". Total = ",score)


func _on_player_killed():
	$UI_Layer/FadeTransition.visible = false
	#is_moving = true
	Engine.time_scale = 1.0
	player.visible = false
	await get_tree().create_timer(0.5).timeout
	gameover.visible = true


func _on_fade_timer_timeout():
	#await get_tree().create_timer(1.5).timeout
	pass
