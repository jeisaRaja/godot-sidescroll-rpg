extends PlayerState
class_name PlayerFall
@onready var anim =  $"../../AnimationPlayer"

func Enter():
	anim.play("PlayerFall")
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(_delta: float):
	if player.is_on_floor():
		Transitioned.emit(self,"PlayerIdle")
