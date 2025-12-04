class_name Signals
extends Node

signal sprite_change(facing: Character.Facing, action: Character.Action)
signal toggle_camera_controls(new_status: bool)
signal bike_minigame_start()
signal bike_minigame_end()
signal interaction_done()

# Audio signals
signal player_step()
signal button_click()