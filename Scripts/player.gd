extends StaticBody2D

## Vars ##

var input: float = 0.0

## Functions ##

func _ready() -> void:
	input = 0.0

func _process(dt: float) -> void:
	if Input.is_action_pressed("pad_up"):
		input -= dt
	if Input.is_action_pressed("pad_dn"):
		input += dt

func _physics_process(dt: float) -> void:
	if self.input > 0.0: self.position.y = clampf(self.position.y + globals.PADDLE_SPEED * dt, -284.0, 284.0)
	elif self.input < 0.0: self.position.y = clampf(self.position.y - globals.PADDLE_SPEED * dt, -284.0, 284.0)
	
	self.input = 0.0
