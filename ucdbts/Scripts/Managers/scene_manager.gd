# Scene manager pulled from tutorial with modifications for our use
# https://www.youtube.com/watch?v=2uYaoQj_6o0

extends Node

signal content_finished_loading(content)
signal content_invalid(content_path: String)
signal content_failed_to_load(content_path: String)

var camera_controller: CameraController
var loading_screen: LoadingScreen
var _loading_screen_scene: PackedScene = preload("res://Scenes/Cameras/loading_screen.tscn")
var _transition: String
var _content_path: String
var _load_progress_timer: Timer
var audio_manager
var title_screen

var first_run: bool


func _init() -> void:
	content_finished_loading.connect(on_content_finished_loading)
	content_invalid.connect(on_content_invalid)
	content_failed_to_load.connect(on_content_failed_to_load)
	
func _ready() -> void:
	# Instantiate singular audio manager to be passed around
	audio_manager = load("res://Scenes/Audio/audio_manager.tscn").instantiate()
	
	# Auto assign audio manager to the first scene
	get_node("/root/Title").add_child(audio_manager)
	
	first_run = true


func load_new_scene(content_path: String, transition_type: String = "fade_to_black") -> void:
	_transition = transition_type
	loading_screen = _loading_screen_scene.instantiate() as LoadingScreen
	get_tree().root.add_child(loading_screen)

	print("Starting transisition")
	loading_screen.start_transition(transition_type)
	_load_content(content_path)
	

func _load_content(content_path: String):
	if loading_screen != null:
		await loading_screen.transition_in_complete
	
	print("Loading content")
	_content_path = content_path
	var loader = ResourceLoader.load_threaded_request(content_path)
	if not ResourceLoader.exists(content_path) or loader == null:
		content_invalid.emit(content_path)
		return
	
	_load_progress_timer = Timer.new()
	_load_progress_timer.wait_time = 0.1
	_load_progress_timer.timeout.connect(monitor_load_status)
	get_tree().root.add_child(_load_progress_timer)
	_load_progress_timer.start()


func monitor_load_status():
	print("Monitoring load status")
	var load_progress = []
	var load_status = ResourceLoader.load_threaded_get_status(_content_path, load_progress)

	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			print("Invalid resource")
			content_invalid.emit(_content_path)
			_load_progress_timer.stop()
			return
		ResourceLoader.THREAD_LOAD_FAILED:
			print("Load failed")
			content_failed_to_load.emit(_content_path)
			_load_progress_timer.stop()
		ResourceLoader.THREAD_LOAD_LOADED:
			print("Loaded")
			_load_progress_timer.stop()
			_load_progress_timer.queue_free()
			content_finished_loading.emit(ResourceLoader.load_threaded_get(_content_path).instantiate())
			print("Emitted content finished loading signal")


func on_content_finished_loading(content) -> void:
	print("Loading new scene")
	
	# Manager audio transfer
	audio_manager.fade_music_out()
	get_tree().current_scene.remove_child(audio_manager)
	content.add_child(audio_manager)
	
	# Scene tranfer
	get_tree().current_scene.queue_free()
	get_tree().root.call_deferred("add_child", content)
	get_tree().set_deferred("current_scene", content)

	if loading_screen != null:
		loading_screen.finish_transition()

		# If content is a level run an init (player location)

		await loading_screen.anim_player.animation_finished
		loading_screen = null

		# If content is a level enter the level function


func on_content_invalid(path: String):
	printerr("error: Cannot load resource: '%s'" % [path])


func on_content_failed_to_load(path: String):
	printerr("error: Failed to load resource: '%s'" % [path])
