extends PlayerState
class_name PlayerJump
@onready var anim =  $"../../AnimationPlayer"

func Enter():
	anim.play("PlayerJump")
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(_delta: float):
	if player.velocity.y > 0:
		Transitioned.emit(self,"PlayerFall")
