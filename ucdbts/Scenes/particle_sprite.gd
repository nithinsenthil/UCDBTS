extends AnimatedSprite2D

enum Facing {
	UP,
	RIGHT,
	DOWN,
	LEFT
}


func play_sparkle() -> void:
	play("sparkle")


func play_rust(facing: Facing) -> void:
	if facing == Facing.UP:
		play("rust_back")
	elif facing == Facing.DOWN:
		play("rust_front")
	else:
		play("rust_side")
