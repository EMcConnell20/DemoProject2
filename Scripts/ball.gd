extends CharacterBody2D

## Vars ##

var speed: float = 0.0
var dir: Vector2 = Vector2(0.0, 0.0)

## Funcs ##

func respawn() -> void:
	self.visible = false
	self.speed = 0.0
	self.position = Vector2(0.0, 0.0)
	
	globals.ball_pos = self.position
	globals.ball_speed = self.speed
	
	$respawn_timer.start()

func reset() -> void:
	self.dir = Vector2(
		-8.0 if randi() % 2 == 0 else 8.0,
		randi_range(-8, 8),
	).normalized() 
	
	globals.ball_pos = self.position
	globals.ball_speed = self.speed
	
	$freeze_timer.start()

func _ready() -> void:
	randomize()

	self.speed = 0.0
	self.position = Vector2(0.0, 0.0)

	globals.ball_pos = self.position
	globals.ball_speed = self.speed

	self.reset()

func _physics_process(dt: float) -> void:
	var collision: KinematicCollision2D = self.move_and_collide(dir * speed * dt)
	
	if collision: self._bounce(collision.get_collider())
	
	globals.ball_pos = self.position

func _bounce(collider: StaticBody2D) -> void:
	var old_direction: Vector2 = self.dir
	
	match collider.collision_layer:
		1: # Paddles
			self.speed = minf(self.speed + globals.BALL_INCR_SPEED, globals.BALL_HIGH_SPEED)
			self.dir = self._rand_bounce(collider)
			globals.ball_speed = self.speed
			
			signals.audio_paddle_bounce.emit(old_direction, self.dir)

		2: # Borders
			self.dir.y *= -1.0
			signals.audio_wall_bounce.emit()

		_: # Goal Posts & Undefined
			return


func _rand_bounce(collider: StaticBody2D) -> Vector2:
	const MAX_DEFLECT_ANGLE: float = (3.0 ** 0.5 / 2.0)
	
	return Vector2(
		1.0 if self.position.x < 0.0 else -1.0,
		(self.position.y - collider.position.y) / 60.0 * MAX_DEFLECT_ANGLE / sqrt(globals.ball_speed / globals.BALL_BASE_SPEED),
	).normalized()

func _on_freeze_timer_timeout() -> void:
	self.speed = globals.BALL_BASE_SPEED
	globals.ball_speed = self.speed

func _on_respawn_timer_timeout() -> void:
	self.visible = true
	self.reset()
