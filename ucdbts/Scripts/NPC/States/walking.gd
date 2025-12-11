class_name NPCWalking
extends NPCState


func _init(npc: NPC) -> void:
	super(npc)
	
	npc.get_node("Locomotion").set_physics_process(true)
	npc.get_node("Sprite2D")._on_sprite_change(_npc._facing, Character.Action.WALK)
	_timeout = 5.0


func _on_talk(npc: NPC) -> NPCState:
	return NPCTalking.new(npc)


func _on_tired(npc: NPC) -> NPCState:
	return NPCStanding.new(npc)


func _on_recovered(npc: NPC) -> NPCState:
	return NPCWalking.new(npc)


func _physics_process(delta: float) -> void:
	_npc.move_and_slide()
	super(delta)
