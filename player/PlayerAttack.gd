extends PlayerState
class_name PlayerAttack
@onready var anim =  $"../../AnimationPlayer"

func Enter():
	anim.play("PlayerAttack")
	player.busy = true
	player.velocity = Vector2(0,0)
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(_delta: float):
	pass
	
func _on_animation_player_animation_finished(anim_name):
	player.busy = false
	Transitioned.emit(self, "PlayerIdle")
