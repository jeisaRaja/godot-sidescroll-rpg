extends State
class_name WallHang

func Enter():
	Anim.play(Actor.name + "WallHang")
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(delta: float):
	if Actor.movement_input.x > 0 and Actor.facing_dir < 0:
		actor_movement()
	if Actor.movement_input.x < 0 and Actor.facing_dir > 0:
		actor_movement()
	if Actor.is_on_floor():
		Transitioned.emit(self, "Idle")
	if Actor.jump_input_actuation:
		Transitioned.emit(self, "Jump")
	if not Actor.is_next_to_wall():
		Transitioned.emit(self, "Fall")
