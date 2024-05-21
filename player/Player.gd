extends CharacterBody2D
signal dash

const SPEED = 300.0
const JUMP_VELOCITY = -300.0
const FRICTION = 1000.0
const ACCELERATION = 5000.0

@onready var ray = $RayCast2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facingDir: int = 1
var busy: bool = false
var canDoubleJump: bool = false

func setVelocity(v: Vector2):
	velocity.x = v.x
	velocity.y = v.y
	if v.x>500: print(velocity)
	move_and_slide()

func GetDirection():
	var direction = Input.get_axis("ui_left", "ui_right")
	var isDashing = Input.is_action_just_pressed("dash")
	
	if isDashing:
		dash.emit()

	return direction
	
func _physics_process(delta):
	apply_gravity(delta)
	handle_wall_jump()
	handle_jump()
	var direction = Input.get_axis("ui_left", "ui_right")
	handle_movement(direction, delta)
	GetDirection()
	setVelocity(Vector2(velocity.x, velocity.y))

func apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta
		
func handle_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		canDoubleJump = true
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("ui_accept") and !is_on_floor() and canDoubleJump:
		canDoubleJump = false
		velocity.y = JUMP_VELOCITY

func handle_wall_jump():
	if not is_on_wall_only(): return
	var wall_normal = get_wall_normal()
	if Input.is_action_just_pressed("ui_accept") and wall_normal == Vector2.RIGHT:
		velocity.x = wall_normal.x * SPEED * 2
		velocity.y = JUMP_VELOCITY

func handle_movement(direction, delta):
	if direction and not busy:
		if not is_on_floor():
			velocity.x = move_toward(velocity.x, SPEED * direction * 0.8, ACCELERATION * delta)
		else:
			velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
			
		if facingDir != direction:
			scale.x *= -1
			facingDir = direction
	else:
		velocity.x = 0	
