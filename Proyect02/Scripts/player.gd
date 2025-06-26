class_name Player
extends CharacterBody2D

signal bullet_shot(bullet_scene, location)
signal hp_depleted

@export var speed = 300
@export var rate_of_fire := 0.05 # Cadencia de Disparo.

@onready var muzzle = $Muzzle
@onready var hp_bar = $"../UI_Layer/HUD/HP_bar"
@onready var sprite_2d = $Sprite2D

var bullet_scene = preload("res://Scenes/bullet.tscn")
var player_hp = 100.0
var shoot_cd := false
var is_moving = false


func _process(delta):
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cd = false
			
	#velocity = dir * speed
	#move_and_slide()


func _physics_process(delta):
	var dir = Vector2(Input.get_axis("ui_left","ui_right"), Input.get_axis("ui_up","ui_down"))
	
	const DAMAGE_RATE = 500.0 # Tasa de daño del Enemigo.
	
	var overlaping_mobs = %DmgBox.get_overlapping_bodies()
	
	if overlaping_mobs.size() > 0:
		for mob in overlaping_mobs:
			player_hp -= DAMAGE_RATE * overlaping_mobs.size() * delta
			hp_bar.value = player_hp
			mob.queue_free()
			if player_hp <= 0.0:
				hp_depleted.emit()
	
	velocity = dir * speed
	move_and_slide()
	
	if dir.x != 0:
		sprite_2d.flip_h = dir.x < 0
		
	print("The velocity is: ", velocity, " and the direction is: ", dir)


func shoot():
	bullet_shot.emit(bullet_scene, muzzle.global_position)

