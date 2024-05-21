extends Node

@export var initialState: PlayerState

var currState: PlayerState
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is PlayerState:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initialState:
		initialState.Enter()
		currState = initialState
			
func _process(delta):
	if currState:
		currState.Update(delta)

func _physics_process(delta):
	if currState:
		currState.Physics_Update(delta)

func on_child_transition(state, newStateName):
	if state != currState:
		return 
	if currState:
		currState.Exit()
	var newState = states.get(newStateName.to_lower())
	newState.Enter()
	currState = newState

