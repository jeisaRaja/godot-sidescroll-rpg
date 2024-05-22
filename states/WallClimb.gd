extends State
class_name WallClimb

func Enter():
	Anim.play(Actor.name + "WallClimb")
	Actor.velocity = Vector2.ZERO
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(_delta:float):
	if Actor.is_on_floor():
		Transitioned.emit(self, "Idle")
