class_name CameraOne
extends CameraController

@export var right_bound:float
@export var left_bound:float
@export var up_bound:float
@export var down_bound:float
@export var draw_logic:bool
var zoom_speed:float = 1.5
var max_zoom:Vector2 = Vector2(2, 2)
var zoom_timer:float = 1
var zoom_timer_on:bool = false
var default_zoom:Vector2 = Vector2(1,1)
var look_speed:float = 800
var controls_enabled:bool = true


func _ready() -> void:
	camera_name = "camera_one"
	signals.toggle_camera_controls.connect(_on_toggle_camera_controls)
	signals.bike_minigame_start.connect(_on_bike_minigame_start)
	signals.bike_minigame_end.connect(_on_bike_minigame_end)
	default_zoom = zoom
	
	signals.npc_caught_player.connect(_on_player_caught)


func _process(delta: float) -> void:
	# target lock
	_move_camera(delta)
	global_position = _target.global_position
	
	if zoom_timer_on and zoom_timer != 0:
		zoom.x = move_toward(zoom.x, max_zoom.x, zoom_speed*delta) 
		zoom.y = move_toward(zoom.y, max_zoom.y, zoom_speed*delta) 
		zoom_timer = move_toward(zoom_timer, 0, delta)
	elif !zoom_timer_on:
		zoom_timer = 1
		if default_zoom != zoom:
			zoom.x = move_toward(zoom.x, default_zoom.x, zoom_speed*delta)
			zoom.y = move_toward(zoom.y, default_zoom.y, zoom_speed*delta)
		
	if draw_logic:
		_draw_logic()


func _move_camera(delta: float) -> void:
	var next_offset:Vector2 = get_local_mouse_position() - offset
	if !Input.is_action_pressed("Look") or !controls_enabled:
		next_offset = Vector2.ZERO
	offset.x = move_toward(offset.x, next_offset.x, look_speed*delta)
	offset.y = move_toward(offset.y, next_offset.y, look_speed*delta)
	offset.x = clampf(offset.x, left_bound, right_bound)
	offset.y = clampf(offset.y, up_bound, down_bound)
		


func _draw_logic() -> void:
	var mesh_instance := MeshInstance2D.new()
	var immediate_mesh := ImmediateMesh.new()
	
	mesh_instance.mesh = immediate_mesh
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	immediate_mesh.surface_add_vertex(Vector3(right_bound, up_bound, 0))
	immediate_mesh.surface_add_vertex(Vector3(left_bound, up_bound, 0))
	immediate_mesh.surface_add_vertex(Vector3(left_bound, up_bound, 0))
	immediate_mesh.surface_add_vertex(Vector3(left_bound, down_bound, 0))
	immediate_mesh.surface_add_vertex(Vector3(left_bound, down_bound, 0))
	immediate_mesh.surface_add_vertex(Vector3(right_bound, down_bound, 0))
	immediate_mesh.surface_add_vertex(Vector3(right_bound, down_bound, 0))
	immediate_mesh.surface_add_vertex(Vector3(right_bound, up_bound, 0))
	immediate_mesh.surface_end()
	
	add_child(mesh_instance)
	mesh_instance.global_position = _target.global_position
	
	await get_tree().process_frame
	mesh_instance.queue_free()


func _on_toggle_camera_controls(new_status) -> void:
	controls_enabled = new_status


func _on_bike_minigame_start() -> void:
	zoom_timer_on = true
	controls_enabled = false


func _on_bike_minigame_end() -> void:
	zoom_timer_on = false
	controls_enabled = true


func _on_player_caught(npc: Character) -> void:
	_target = npc
