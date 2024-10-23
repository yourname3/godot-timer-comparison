# Godot Timer Comparison

This is a demo project that shows that using await with a get_tree().create_timer() timer is not as correct as using a manual accumulator.

My suspicion that led me to want to create this was that Godot's timers do not account for the sub-frame offset of the timer, that is, Godot's timers are effectively similar to:

```
var timer = 0

func _process(delta):
  if timer <= 0:
    fire_timer()
    timer = TIMER_LENGTH
  timer -= delta
```

whereas the correct timer would be:

```
var timer = 0

func _process(delta):
  if timer <= 0:
    fire_timer()
    timer += TIMER_LENGTH
  timer -= delta
```

Notice that we ADD the timer length, so that we don't throw away any additional accumulated time.

To understand how this project tests this, you can run it: the left-hand Godot icon is using a manual timer, while the right Godot icon is using a get_tree() timer. Each icon counts the number of times it has fired(), and these are compared to
the ground truth computed from the actual elapsed time (using Time.get_ticks_us()). The console will show that the manual timer matches the ground truth exactly while the get_tree() timer quickly drifts.
