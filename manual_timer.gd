extends Sprite2D

var timer = 0.0
var switch_count = 0

func fire():
	self.position.y *= -1
	switch_count += 1

func _process(delta):
	if timer <= 0.0:
		fire()
		timer += get_parent().TIMER_LENGTH
	timer -= delta
