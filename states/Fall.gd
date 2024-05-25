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
	Actor.apply_gravity(delta)
	if Actor.is_on_floor():
		Transitioned.emit(self, "Idle")
	if Actor.dash_input and Actor.can_dash:
		Transitioned.emit(self, "Dash")
	if Actor.is_next_to_wall() and Actor.velocity.y > 0 and not Actor.is_hanging():
		print(Actor.is_next_to_wall(), Actor.is_hanging())
		Transitioned.emit(self, "WallSlide")
	if Actor.jump_input_actuation and Actor.jump_count < Actor.max_jump_count:
		Transitioned.emit(self, "Jump")
	if Actor.is_hanging():
		print("is hanging")
		Transitioned.emit(self, "WallHang")
