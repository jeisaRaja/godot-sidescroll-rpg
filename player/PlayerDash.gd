extends PlayerState
class_name PlayerDash
@onready var anim =  $"../../AnimationPlayer"
@export var timer: Timer

func Enter():
	anim.play("PlayerDash")
	print("entering dashing")
	timer.start()
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(_delta:float):
	player.setVelocity(Vector2(400 * player.GetDirection(),player.velocity.y))
	
func _on_dash_timer_timeout():
	print("timeout")
	player.busy = false
	Transitioned.emit(self, "PlayerIdle")
