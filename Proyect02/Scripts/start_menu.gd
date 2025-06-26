class_name StartMenu
extends Control

@onready var par_background = $ParallaxBackground
var button_type = null
var scroll_speed = 25

func _ready():
	$StartMarginContainer/StartVBoxContainer/StartButton/AnimationPlayer.play("CTA")
	$FadeTransition.show()
	$FadeTransition/FadeTimer.start()
	$FadeTransition/AnimationPlayer.play("fade_out")
	await get_tree().create_timer(0.9).timeout
	$FadeTransition.visible = false


func _process(delta):
	par_background.scroll_offset.y += delta * scroll_speed
	if par_background.scroll_offset.y >= 550:
		par_background.scroll_offset.y = 0
	print(par_background.scroll_offset.y)


func _on_start_button_pressed():
	button_type = "start"
	$FadeTransition.show()
	$FadeTransition/FadeTimer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")


func _on_quit_button_pressed():
	button_type = "quit"
	$FadeTransition.show()
	$FadeTransition/FadeTimer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")


func _on_mute_button_pressed():
	pass


func _on_fade_timer_timeout():
	if button_type == "start":
		await get_tree().create_timer(0.9).timeout
		get_tree().change_scene_to_file("res://Scenes/game.tscn")
	elif button_type == "quit":
		await get_tree().create_timer(0.9).timeout
		get_tree().quit()
