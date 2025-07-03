class_name Bullet
extends Area2D

@export var speed = 600
@export var damage = 1

var time_scale := 1.0

func set_time_scale(scale: float):
	time_scale = scale

func _ready():
	add_to_group("gameplay")

func _physics_process(delta):
	var scaled_delta = delta * time_scale
	global_position.y += -speed * scaled_delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Enemy:
		area.enemy_hit(damage)
		queue_free()


func _on_body_entered(body):
	if body is Enemy_character_body_2D :
		body.enemy_hit(damage)
		queue_free()
