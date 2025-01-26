extends CharacterBody2D

## Vars ##

var speed: float = 0.0
var dir: Vector2 = Vector2(0.0, 0.0)

## Funcs ##

func _ready() -> void:
	randomize()
	self.reset()

func _physics_process(dt: float) -> void:
	var collision: KinematicCollision2D = self.move_and_collide(dir * speed * dt)
	
	# TODO - Move this block a separate function
	if collision:
		var collider: StaticBody2D = collision.get_collider()
		
		if collider == $"../player" || collider == $"../bot":
			if self.position.x > -640.0 && self.position.x < 640.0:
				self.speed = clampf(
					self.speed + globals.BALL_INCR_SPEED,
					globals.BALL_BASE_SPEED,
					globals.BALL_HIGH_SPEED
				)
				
				self.dir = self.rand_bounce(collider)
		elif collider == $"../border":
			self.dir = self.dir.bounce(collision.get_normal())
	
	globals.ball_pos = self.position
	globals.ball_speed = self.speed

func _on_baller_timeout() -> void:
	self.speed = globals.BALL_BASE_SPEED

func reset() -> void:
	self.position = Vector2(0.0, 0.0)
	self.speed = 0.0
	self.dir = Vector2(
		-8.0 if randi() % 2 == 0 else 8.0,
		randi_range(-8, 8),
	).normalized()
	
	globals.ball_pos = self.position
	globals.ball_speed = self.speed
	
	$baller.start()

func rand_bounce(collider: StaticBody2D) -> Vector2:
	const MAX_DEFLECT_ANGLE: float = (2.0 ** 0.5 / 2.0)
	
	var new_dir: Vector2 = Vector2(1.0 if self.position.x < 0.0 else -1.0, 0.0)
	
	new_dir.y = -(collider.position.y - self.position.y) / (60.0) * MAX_DEFLECT_ANGLE
	
	return new_dir.normalized()
