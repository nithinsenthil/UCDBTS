class_name Signals
extends Node

@warning_ignore_start("unused_signal")

signal sprite_change(facing: Character.Facing, action: Character.Action)

signal toggle_camera_controls(new_status: bool)
signal bike_minigame_start()
signal bike_minigame_end()
signal interaction_done()

# Audio signals
signal player_step()
signal button_click()

# NPC Signals
signal player_visually_sus(location: Vector2, sus_level: float)
signal player_audially_sus(location: Vector2, sus_level: float)

signal spawn_npc()
signal npc_caught_player(npc: Character)

@warning_ignore_restore("unused_signal")
