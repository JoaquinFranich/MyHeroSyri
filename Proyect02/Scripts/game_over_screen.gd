class_name GameOverScreen
extends Control

var button_type = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_replay_button_pressed():
	button_type = "replay"
	$FadeTransition.show()
	$FadeTransition/FadeTimer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")


func _on_home_button_pressed():
	button_type = "home"
	$FadeTransition.show()
	$FadeTransition/FadeTimer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")



func _on_fade_timer_timeout():
	if button_type == "replay":
		print("El boton REPLAY fue presionado...")
		await get_tree().create_timer(0.9).timeout
		get_tree().change_scene_to_file("res://Scenes/game.tscn")
	elif button_type == "home":
		Engine.time_scale = 1.0
		print("El boton HOME fue presionado...")
		await get_tree().create_timer(0.9).timeout
		get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
