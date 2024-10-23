# Godot Timer Comparison

This is a demo project that shows that using await with a get_tree().create_timer() timer is not as correct as using a manual accumulator.

My suspicion that led me to want to create this was that Godot's timers do not account for the sub-frame offset of the timer, that is, my suspicion was that Godot's timers are effectively similar to:

```
# Bad manual timer
var timer = 0

func _process(delta):
  if timer <= 0:
    fire_timer()
    timer = TIMER_LENGTH
  timer -= delta
```

whereas the correct timer would be:

```
# Good manual timer
var timer = 0

func _process(delta):
  if timer <= 0:
    fire_timer()
    timer += TIMER_LENGTH
  timer -= delta
```

Notice that we ADD the timer length, so that we don't throw away any additional accumulated time.

To understand how this project tests this, you can run it: the left Godot icon is using a manual timer, while the middle Godot icon is using a get_tree() timer. The rightmost Godot icon (the bluer one) is the "bad manual" timer code from above. Each icon counts the number of times it has fired(), and these are compared to the ground truth computed from the actual elapsed time (using Time.get_ticks_us()). The console will show that the manual timer matches the ground truth exactly while the get_tree() timer quickly drifts.

Running the demo will also show that the get_tree() timer and the bad manual timer behave very similarly, although not identically. This may be an off-by-one error in terms of frames or perhaps something more significant. In any case, my hypothesis that the timer is behaviorly similar to a bad manual timer appears to be correct.
