class_name Bullet
extends Area2D

@export var speed = 600
@export var damage = 1

func _physics_process(delta):
	global_position.y += -speed * delta


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
