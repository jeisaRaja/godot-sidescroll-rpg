extends "State.gd"
class_name Jump

func Enter():
	Anim.play(Actor.name + "Jump")
	Actor.velocity.y = Actor.JUMP_VELOCITY
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(delta: float):
	actor_movement()
	if Actor.velocity.y > 0:
		Transitioned.emit(self, "Fall")
	if Actor.dash_input and Actor.can_dash:
		Transitioned.emit(self, "Dash")
