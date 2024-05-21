extends "State.gd"
class_name Idle

func Enter():
	Anim.play(Actor.name + "Idle")

func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(_delta: float):
	if Actor.movement_input.x != 0:
		Transitioned.emit(self, "Walk")
	if Actor.jump_input_actuation == true:
		Transitioned.emit(self, "Jump")
	if Actor.velocity.y > 0:
		Transitioned.emit(self, "Fall")
	if Actor.dash_input:
		Transitioned.emit(self, "Dash")
