extends State
class_name Attack

func Enter():
	Anim.play(Actor.name + "Attack")
	Actor.busy = true
	Actor.velocity = Vector2(0,0)
	
func Update(_delta: float):
	pass

func Exit():
	pass
	
func Physics_Update(_delta: float):
	pass

