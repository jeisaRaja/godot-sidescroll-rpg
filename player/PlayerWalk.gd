extends State
class_name PlayerWalk
@onready var anim =  $"../../AnimationPlayer"

@export var player: CharacterBody2D

func Enter():
	anim.play("PlayerWalk")
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(_delta: float):
	if player.velocity.x == 0:
		Transitioned.emit(self,"PlayerIdle")
