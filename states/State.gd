extends Node
class_name State

signal Transitioned(state, newStateName)

var Actor: ActorClass = null
var Anim: AnimationPlayer = null
var FMS = null

func Enter():
	pass
	
func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass

func actor_movement():
	if Actor.movement_input.x > 0:
		Actor.velocity.x = Actor.SPEED
	elif Actor.movement_input.x < 0:
		Actor.velocity.x = - Actor.SPEED
	else:
		Actor.velocity.x = 0
	if Actor.movement_input.x and Actor.facingDir.x != Actor.movement_input.x:
		Actor.scale.x *= -1
		Actor.facingDir.x = Actor.movement_input.x
