extends PlayerState
class_name PlayerIdle
@onready var anim =  $"../../AnimationPlayer"

func Enter():
	super.Enter()
	anim.play("PlayerIdle")

func Exit():
	pass
	
func Physics_Update(_delta: float):
	super.Physics_Update(_delta)

