extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
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
	if direction and not busy:
		velocity.x = direction * SPEED
		if facingDir != direction:
			scale.x *= -1
			facingDir = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	return direction
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		canDoubleJump = true
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("ui_accept") and !is_on_floor() and canDoubleJump:
		canDoubleJump = false
		velocity.y = JUMP_VELOCITY

	GetDirection()
	setVelocity(Vector2(velocity.x, velocity.y))
