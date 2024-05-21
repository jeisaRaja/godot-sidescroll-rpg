extends PlayerState
class_name PlayerWalk
@onready var anim =  $"../../AnimationPlayer"

func Enter():
	anim.play("PlayerWalk")
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(_delta: float):
	super.Physics_Update(_delta)
	if player.velocity.x == 0 and player.is_on_floor():
		Transitioned.emit(self,"PlayerIdle")
	if not player.is_on_floor():
		Transitioned.emit(self, "PlayerJump")

func _on_player_dash():
	Transitioned.emit(self, "PlayerDash")
