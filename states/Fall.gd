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
	if Actor.dash_input and Actor.can_dash:
		Transitioned.emit(self, "Dash")
	if Actor.is_next_to_wall() and Actor.velocity.y > 0:
		Transitioned.emit(self, "WallSlide")
