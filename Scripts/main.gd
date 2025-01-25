extends Sprite2D

## Consts ##

## Variables ##

var score: Array[int] = [0, 0] # 0 = Player | 1 = Bot

## Functions ##

func _ready() -> void:
	pass

func _process(_dt: float) -> void:
	pass

func _on_baller_timeout() -> void:
	$ball.reset()


func _on_posts_body_entered(body: Node2D) -> void: 
	if body.position.x < 0.0:
		score[1] += 1
		$ui/bot_score.text = str(score[1])
	else:
		score[0] += 1
		$ui/player_score.text = str(score[0])
		
	$ball.speed = 0.0
	$ball.position = Vector2(0.0, 0.0)
	$baller.start()
