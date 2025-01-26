extends Node

## Consts ##

const PADDLE_SPEED: float = 256.0
const BALL_BASE_SPEED: float = 388.0
const BALL_HIGH_SPEED: float = 768.0
const BALL_INCR_SPEED: float = 32.0

## Vars ##

var ball_pos: Vector2 = Vector2(0.0, 0.0)
var ball_speed: float = 0.0

## Funcs ##

func _ready() -> void:
	pass
