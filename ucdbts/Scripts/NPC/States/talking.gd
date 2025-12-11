class_name NPCTalking
extends NPCState


func _init(npc: NPC) -> void:
	super(npc)
	
	npc.get_node("Locomotion").set_physics_process(false)
	npc.get_node("Sprite2D")._on_sprite_change(_npc._facing, Character.Action.IDLE)
	npc.set_velocity.call_deferred(Vector2.ZERO)
	_timeout = 5.0


func _on_talk(__npc: NPC) -> NPCState:
	return self


func _on_tired(npc: NPC) -> NPCState:
	return NPCStanding.new(npc)


func _on_recovered(npc: NPC) -> NPCState:
	return NPCWalking.new(npc)
