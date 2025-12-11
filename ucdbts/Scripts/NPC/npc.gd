class_name NPC
extends Character

var state: NPCState


func _ready() -> void:
	state = NPCWalking.new(self)


func _physics_process(delta: float) -> void:
	state._physics_process(delta) # move_and_slide called here
	if state.expired:
		if randf() < 0.05:
			state = state._on_tired(self)
		else:
			state = state._on_recovered(self)


func _on_talk(_body: Node2D) -> void:
	if _body is not NPC:
		pass
	
	var npc = _body as NPC
	
	state = state._on_talk(self)
	
	# Cause other NPC to talk to us if not already (avoids recursion)
	if npc.state is not NPCTalking:
		npc._on_talk(self)
	
	_facing = Locomotion.get_facing(global_position.direction_to(npc.global_position))
	var animation : NPCSprite = get_node("Sprite2D")
	animation._on_sprite_change(
		_facing,
		Character.Action.IDLE
	)
