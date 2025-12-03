class_name CameraOne
extends CameraController

@export var right_bound:float
@export var left_bound:float
@export var up_bound:float
@export var down_bound:float
@export var draw_logic:bool


func _ready() -> void:
	camera_name = "camera_one"


func _process(_delta: float) -> void:
	# target lock
	_move_camera()
	global_position = _target.global_position
	if draw_logic:
		_draw_logic()


func _move_camera() -> void:
	offset = get_local_mouse_position() - offset
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
