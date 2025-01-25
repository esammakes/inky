import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flame/events.dart';

//a flame game - where you tap the screen
class InkyGame extends FlameGame with TapCallbacks {
  // @override
  Color backgroundColor() => Colors.blue;

  @override
  void onTapDown(TapDownEvent event) {
    final position = event.localPosition;
    add(InkDrop(Vector2(position.x, position.y)));
  }
}

class InkDrop extends CircleComponent {
  Paint inkPaint = Paint()
    ..color = Colors.black
    ..blendMode = BlendMode.multiply;

  InkDrop(Vector2 position)
      : super(
          radius: 10, //default small radius
          anchor: Anchor.center, //ensures the circle is centered on the tap
        ) {
    this.position = position; //directly assign the position
  }

  @override
  void update(double dt) {
    radius += dt * 15; // Expands over time
    inkPaint.color = inkPaint.color.withOpacity(0.9);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset.zero, radius, inkPaint);
  }
}
