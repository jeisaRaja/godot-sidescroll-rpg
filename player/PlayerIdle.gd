extends State
class_name PlayerIdle
@onready var anim =  $"../../AnimationPlayer"

@export var player: CharacterBody2D

func Enter():
	super.Enter()
	anim.play("PlayerIdle")

func Exit():
	pass
	
func Physics_Update(_delta: float):
	if player.velocity.x != 0:
		Transitioned.emit(self,"PlayerWalk")
