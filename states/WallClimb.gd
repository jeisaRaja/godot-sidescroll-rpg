extends State
class_name WallClimb

var offset: Vector2 = Vector2.ZERO

func Enter():
	Anim.play(Actor.name + "WallClimb")
	Actor.velocity = Vector2.ZERO
	if Actor.facing_dir > 0:
		offset += Vector2(15,-30)
		Actor.offset_camera(offset)
	if Actor.facing_dir < 0:
		offset +=  Vector2(-15,-30)
		Actor.offset_camera(offset)
	
func Update(_delta: float):
	pass

func Exit():
	Actor.offset_camera(-offset)
	offset = Vector2.ZERO
	
func Physics_Update(_delta:float):
	if not Anim.is_playing():
		Actor.position += offset
		Transitioned.emit(self, "Idle")
