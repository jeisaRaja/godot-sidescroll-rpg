extends State
class_name Attack

@onready var combo_timer: Timer = $ComboTimer
var combo_count = 0

func Enter():
	if combo_timer.is_stopped():
		combo_count = 0
	if combo_count == 0:
		Anim.play(Actor.name + "Attack")
		combo_count += 1
	else:
		Anim.play(Actor.name + "Attack2")
		combo_count = 0
	Actor.velocity = Vector2(0,0)
	
func Update(_delta: float):
	pass

func Exit():
	combo_timer.start()
	
func Physics_Update(_delta: float):
	if not Anim.is_playing():
		Transitioned.emit(self, "Idle")

