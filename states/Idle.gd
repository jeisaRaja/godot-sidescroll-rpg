extends "State.gd"
class_name Idle

func Enter():
	Anim.play(Actor.name + "Idle")
	Actor.velocity = Vector2.ZERO
	Actor.jump_count = 0

func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(_delta: float):
	Actor.apply_gravity(_delta)
	if Actor.movement_input.x != 0:
		Transitioned.emit(self, "Walk")
	if Actor.jump_input_actuation == true:
		Transitioned.emit(self, "Jump")
	if Actor.velocity.y > 0 and not Actor.can_coyote:
		Transitioned.emit(self, "Fall")
	if Actor.dash_input and Actor.can_dash:
		Transitioned.emit(self, "Dash")
	if Actor.attack_input:
		Transitioned.emit(self, "Attack")
