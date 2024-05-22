extends State
class_name WallSlide

func Enter():
	Anim.play(Actor.name + "WallSlide")
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(_delta:float):
	if Actor.is_on_floor():
		Transitioned.emit(self, "Idle")
