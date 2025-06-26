class_name HUD
extends Control

@onready var score = $Score:
	set(value):
		#$Score/AnimationPlayer.play("POV")
		score.text = "Score: " + str(value)
@onready var anim_timer = $Score/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
