extends State
class_name WallHang

func Enter():
	Anim.play(Actor.name + "WallHang")
	Actor.velocity = Vector2.ZERO
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(delta: float):
	if Actor.movement_input.x > 0 and Actor.facing_dir < 0:
		Transitioned.emit(self, "Fall")
	if Actor.movement_input.x < 0 and Actor.facing_dir > 0:
		Transitioned.emit(self, "Fall")
	if Actor.is_on_floor():
		Transitioned.emit(self, "Idle")
	if Actor.jump_input_actuation:
		Transitioned.emit(self, "WallClimb")
	if Actor.is_next_to_wall() and not Actor.is_hanging():
		Transitioned.emit(self, "WallSlide")
	if Actor.movement_input.y < 0:
		Transitioned.emit(self, "WallCLimb")
