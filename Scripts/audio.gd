extends AudioStreamPlayer

## Consts ##

const PADDLE_NOISE: AudioStreamWAV = preload("res://Assets/Audio/bounce.wav")
const WALL_BOUNCE_NOISE: AudioStreamWAV = preload("res://Assets/Audio/wall_bounce.wav")

## Funcs ##

func _ready() -> void:
	signals.audio_paddle_bounce.connect(_play_paddle_bounce)
	signals.audio_wall_bounce.connect(_play_wall_bounce)

func _play_paddle_bounce(old_direction: Vector2, new_direction: Vector2) -> void:
	self.stop()
	self.stream = PADDLE_NOISE
	self.pitch_scale = 1.0 + old_direction.dot(new_direction) / 32.0 * globals.BALL_BASE_SPEED / globals.ball_speed
	self.play()

func _play_wall_bounce() -> void:
	self.stop()
	self.stream = WALL_BOUNCE_NOISE
	self.pitch_scale = 1.0
	self.play()
