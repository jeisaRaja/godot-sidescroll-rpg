extends State
class_name WallSlide

func Enter():
	Anim.play(Actor.name + "WallSlide")
	ActorSprite.scale.x *= -1
	
func Update(_delta: float):
	pass

func Exit():
	ActorSprite.scale.x *= -1
	
func Physics_Update(_delta:float):
	Actor.velocity.y = 50
	actor_movement()
	if Actor.is_on_floor():
		Transitioned.emit(self, "Idle")
	if Actor.jump_input_actuation:
		Transitioned.emit(self, "Jump")
	if not Actor.is_next_to_wall():
		Transitioned.emit(self, "Fall")
