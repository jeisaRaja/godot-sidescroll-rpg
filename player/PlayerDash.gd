extends PlayerState
class_name PlayerDash
@onready var anim =  $"../../AnimationPlayer"
@export var timer: Timer

func Enter():
	anim.play("PlayerDash")
	player.setVelocity(Vector2(400 * player.GetDirection(),0))
	print(player.velocity)
	timer.start()
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func _on_dash_timer_timeout():
	print("timeout")
	player.busy = false
	Transitioned.emit(self, "PlayerIdle")
