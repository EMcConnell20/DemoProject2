extends CharacterBody2D

## Consts ##

const BASE_SPEED: float = 388.0
const TOP_SPEED: float = 768.0
const INCR_SPEED: float = 32.0

## Vars ##

var speed: float = 0.0
var dir: Vector2 = Vector2(0.0, 0.0)

## Funcs ##

func _ready() -> void:
	randomize()

func _physics_process(dt: float) -> void:
	var collision: KinematicCollision2D = self.move_and_collide(dir * speed * dt)
	
	if collision:
		var collider: StaticBody2D = collision.get_collider()
		
		if collider == $"../player" or collider == $"../bot":
			if self.position.x > -640.0 && self.position.x < 640.0:
				self.speed = clampf(self.speed + self.INCR_SPEED, BASE_SPEED, TOP_SPEED)
				self.dir = rand_bounce(collider)
		elif collider == $"../border":
			self.dir = self.dir.bounce(collision.get_normal())
	
func reset() -> void:
	self.position = Vector2(0.0, 0.0)
	self.speed = BASE_SPEED
	self.dir = Vector2(-8.0, randi_range(-8, 8)).normalized()

func rand_bounce(collider: StaticBody2D) -> Vector2:
	var new_dir: Vector2 = Vector2(1.0 if self.position.x < 0.0 else -1.0, 0.0)
	new_dir.y = -(collider.position.y - self.position.y) / (64.0) * (2.0 ** 0.5 / 2.0)
	return new_dir.normalized()
