extends Sprite2D

var switch_count = 0

func fire():
	self.position.y *= -1
	switch_count += 1

func _ready():
	while true:
		fire()
		await get_tree().create_timer(get_parent().TIMER_LENGTH).timeout
