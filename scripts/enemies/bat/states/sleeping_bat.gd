class_name SleepingBatState
extends State


func physics_update(_delta: float) -> void:
	if state_owner.alerted:
		change_state("ChasingState")
