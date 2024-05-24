extends "State.gd"
class_name Walk

func Enter():
	Anim.play(Actor.name + "Walk")
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(_delta: float):
	actor_movement()
	Actor.apply_gravity(_delta)
	if Actor.velocity.x == 0:
		Transitioned.emit(self, "Idle")
	if Actor.velocity.y > 0 and not Actor.can_coyote:
		Transitioned.emit(self, "Fall")
	if Actor.jump_input_actuation:
		Transitioned.emit(self, "Jump")
	if Actor.dash_input and Actor.can_dash:
		Transitioned.emit(self, "Dash")
	if Actor.attack_input:
		Transitioned.emit(self, "Attack")
