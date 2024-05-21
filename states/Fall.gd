extends State
class_name Fall

func Enter():
	Anim.play(Actor.name + "Fall")
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(delta: float):
	actor_movement()
	if Actor.is_on_floor():
		Transitioned.emit(self, "Idle")
	if Actor.dash_input:
		Transitioned.emit(self, "Dash")
