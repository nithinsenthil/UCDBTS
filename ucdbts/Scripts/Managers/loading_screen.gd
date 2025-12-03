class_name LoadingScreen
extends Node

signal transition_in_complete


@onready var anim_player: AnimationPlayer = %AnimationPlayer
@onready var timer: Timer = $Timer

var starting_animation_name: String


func _ready() -> void:
	SceneManager.content_finished_loading.connect(test)

func start_transition(animation_name: String):
	if !anim_player.has_animation(animation_name):
		push_warning("'%s' animation does not exist" % animation_name)
		animation_name = "fade_to_black"
	starting_animation_name = animation_name
	print("Playing: " + animation_name)
	anim_player.play(animation_name)

	timer.start()


func finish_transition():
	if timer:
		timer.stop()
	
	var ending_animation_name: String = starting_animation_name.replace("to", "from")

	if !anim_player.has_animation(ending_animation_name):
		push_warning("'%s' animation does not exist" % ending_animation_name)
		ending_animation_name = "fade_from_black"
	anim_player.play(ending_animation_name)

	await anim_player.animation_finished
	queue_free()

func report_midpoint() -> void:
	transition_in_complete.emit()

func test(content):
	print("TRIGGERED FROM LOADING SCREEN")
