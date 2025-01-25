extends StaticBody2D

## Consts ##

var SPEED: float = 256.0

## Vars ##

var ball_pos: Vector2 = Vector2(0.0, 0.0)
var ball_speed: float = 0.0

## Funcs ##

func _ready() -> void:
	pass

func _process(_dt: float) -> void:
	ball_pos = $"../ball".position
	ball_speed = $"../ball".speed

func _physics_process(dt: float) -> void:
	var goal: float = (0.0 - self.position.y) / 64.0 * ((-ball_pos.x + 700.0) / 640.0) ** 2
	
	var d_mod: float = ((-ball_pos.x + 700.0) ** 2)
	if d_mod == 0.0: d_mod += 0.01
	
	goal += ((ball_pos.y - self.position.y) * abs(ball_pos.y - self.position.y) * 128.0 * ball_speed ** 2 / (d_mod * 300.0 ** 2))
	goal = clampf(goal, -1.0, 1.0)
	
	self.position.y = clampf(self.position.y + goal * self.SPEED * dt, -288.0, 288.0)
