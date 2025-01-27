extends StaticBody2D

## Funcs ##

func _physics_process(dt: float) -> void:
	# Verticle Direction Tp Move Towards
	var goal: float = 0.0
	
	# Speed Of The Ball (As A Factor)
	var ball_speed_factor: float = sqrt(globals.ball_speed / globals.BALL_BASE_SPEED)
	
	# Distance From The Ball (As A Factor)
	var ball_distance_factor: float = (-globals.ball_pos.x / 320.0 + 2.0) ** 2.0
	if ball_distance_factor == 0.0: ball_distance_factor = 0.01
	
	# Sets goal to distance from middle of screen
	goal = (0.0 - self.position.y) / 60.0
	goal *= ball_distance_factor
	goal *= ball_speed_factor
	
	# Factors vertical distance to ball
	goal += (
		(globals.ball_pos.y - self.position.y) # Distance from paddle to ball
		* abs(globals.ball_pos.y - self.position.y) # Squares it while keeping the sign
		/ 360.0 # (Paddle Height * 0.5)^2
		/ ball_distance_factor
		* ball_speed_factor ** 2.0
	)
	
	# Believe it or not, this thing actually tends to be within [-1, 1]
	goal = clampf(goal, -1.0, 1.0)
	
	self.position.y = clampf(self.position.y + globals.PADDLE_SPEED * goal * dt, -284.0, 284.0)
