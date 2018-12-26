# Confetti

A Flutter app that showcases performance issues.

## Issues

### Opacity
With many small widgets: [`/videos/opacity.mp4`](https://github.com/maryx/confetti/tree/master/videos/opacity.mp4).
With fewer large widgets: [`/videos/opacity2.mp4`](https://github.com/maryx/confetti/tree/master/videos/opacity2.mp4).

### Blur
With blur: [`/videos/blur.mp4`](https://github.com/maryx/confetti/tree/master/videos/blur.mp4).

### Number of widgets
With a lot of widgets: [`/videos/numConfetti.mp4`](https://github.com/maryx/confetti/tree/master/videos/numConfetti.mp4).

### Other things to try:
 - Size of the widgets (if there are many stacked on top of each other/overlapping, it might affect how difficult it is to render the the blur/opacity?)
 - How frequently the widgets redraw (my timer is currently 125 ms)
 - Whether there is a background image
 - Widgets that rely on system DateTime to build
 - Shape of the widgets