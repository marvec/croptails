class_name GameInputEvents

static var direction: Vector2

static func movement_input() -> Vector2:
	if Input.is_action_pressed("walk_left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("walk_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("walk_up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("walk_down"):
		direction = Vector2.DOWN
	else:
		direction = Vector2.ZERO
		
	return direction

static func is_movement_input() -> bool:
	return direction != Vector2.ZERO

static func get_movement_input(event: InputEvent) -> Vector2:
	if is_action_active(event, "walk_left"):
		direction = Vector2.LEFT
	elif is_action_active(event, "walk_right"):
		direction = Vector2.RIGHT
	elif is_action_active(event, "walk_up"):
		direction = Vector2.UP
	elif is_action_active(event, "walk_down"):
		direction = Vector2.DOWN
	else:
		direction = Vector2.ZERO
		
	return direction

static func is_action_active(event: InputEvent, action: String) -> bool:
	return event.is_action(action) && (event.is_pressed() || event.is_echo())

static func is_use_tool(event: InputEvent) -> bool:
	return is_action_active(event, "hit")
