extends "State.gd"
class_name Jump


func Enter():
	Anim.play(Actor.name + "Jump")
	Actor.velocity.y = Actor.JUMP_VELOCITY
	Actor.jump_count += 1
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(delta: float):
	actor_movement()
	Actor.apply_gravity(delta)
	if Actor.velocity.y > 0:
		Transitioned.emit(self, "Fall")
	if Actor.dash_input and Actor.can_dash:
		Transitioned.emit(self, "Dash")
	if Actor.is_next_to_wall() and Actor.velocity.y > 0:
		Transitioned.emit(self, "WallSlide")
	if Actor.jump_input_actuation and Actor.jump_count < Actor.max_jump_count:
		Transitioned.emit(self, "Jump")
