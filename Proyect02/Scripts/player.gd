class_name Player
extends CharacterBody2D

signal bullet_shot(bullet_scene, location)
signal hp_depleted

@export var speed = 300
@export var rate_of_fire := 0.05 # Cadencia de Disparo.

@onready var muzzle = $Muzzle
@onready var hp_bar = $"../../UI_Layer/HUD/HP_bar"
@onready var sprite_2d = $Sprite2D

var bullet_scene = preload("res://Scenes/bullet.tscn")
var player_hp = 100.0
var shoot_cd := false
var is_moving = false
var time_scale := 1.0


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
	var scaled_delta = delta * time_scale
	var dir = Vector2(Input.get_axis("ui_left","ui_right"), Input.get_axis("ui_up","ui_down"))
	
	const DAMAGE_RATE = 500.0 # Tasa de daño del Enemigo.
	
	var overlaping_mobs = %DmgBox.get_overlapping_bodies()
	
	if overlaping_mobs.size() > 0:
		for mob in overlaping_mobs:
			player_hp -= DAMAGE_RATE * overlaping_mobs.size() * scaled_delta
			hp_bar.value = player_hp
			mob.queue_free()
			if player_hp <= 0.0:
				hp_depleted.emit()
	
	velocity = dir * speed
	move_and_slide()
	
	if dir.x != 0:
		sprite_2d.flip_h = dir.x < 0
		
	#print("The velocity is: ", velocity, " and the direction is: ", dir)


func shoot():
	bullet_shot.emit(bullet_scene, muzzle.global_position)


func set_time_scale(scale: float):
	time_scale = scale


func _ready():
	add_to_group("gameplay")


func _on_hp_depleted():
	# Handle player death
	visible = false
	set_physics_process(false)
	set_process(false)


func player_hit():
	# Handle player being hit by enemy
	player_hp -= 10  # Reduce health by 10
	hp_bar.value = player_hp
	if player_hp <= 0.0:
		hp_depleted.emit()

