extends Node

class_name State

var state_owner : Node

func enter() -> void:
	pass


func physics_update(_delta: float) -> void:
	pass

func update(_delta: float) -> void: #will be of interest in future (spin attack etc.)
	pass

func change_state(state_name: String) -> void:
	if not state_owner.states.has(state_name):
		push_error("State '%s' does not exist!" % state_name)
		return
	
	state_owner.current_state = state_owner.states[state_name]
	state_owner.current_state.enter()
