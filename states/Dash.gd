extends State
class_name Dash

@export var dash_duration: float = 0.2
@export var ghost_duration: float = 0.05
@onready var dash_cooldown_timer = $"../../Timer/DashCooldown"
@onready var dash_duration_timer = $DashDuration
@onready var ghost_timer = $Ghost

var dash_dir = Vector2.RIGHT
var dash_speed = 500
var is_dashing = false

func Enter():
	is_dashing = true
	Actor.can_dash = false
	dash_cooldown_timer.start(Actor.dash_cooldown)
	dash_duration_timer.start(dash_duration)
	ghost_timer.start(ghost_duration)
	
	if Actor.movement_input.x != 0:
		dash_dir = Actor.movement_input.x
	else:
		dash_dir = Actor.facing_dir
	Anim.play(Actor.name + "Dash")
	Actor.velocity.x = dash_dir * dash_speed
	
func Update(_delta: float):
	pass

func Exit():
	is_dashing = false
	ghost_timer.stop()
	
func Physics_Update(_delta:float):
	Actor.velocity.y = 0
	if not is_dashing:
		Transitioned.emit(self, "Fall")

func _on_ghost_timeout():
	Actor.add_ghost()

func _on_dash_duration_timeout():
	is_dashing = false
