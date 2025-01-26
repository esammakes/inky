import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class FluidSimulation extends PositionComponent {
  final int gridSize = 100; //resolution of simulation
  final double diffusionRate = 0.2;
  final double feedRate = 0.055;
  final double killRate = 0.062;
  late List<List<double>> inkGrid; //use 'late' to delay initialization

  FluidSimulation() {
    inkGrid = List.generate(gridSize, (_) => List.filled(gridSize, 0.0));
  }

  void addInk(Vector2 position) {
    int x = (position.x / size.x * gridSize).clamp(0, gridSize - 1).toInt();
    int y = (position.y / size.y * gridSize).clamp(0, gridSize - 1).toInt();
    inkGrid[x][y] = 1.0; //set ink concentration
  }

  @override
  void update(double dt) {
    //apply diffusion and reaction-diffusion rules/gray scott model
    List<List<double>> newGrid =
        List.generate(gridSize, (_) => List.filled(gridSize, 0.0));
    for (int x = 1; x < gridSize - 1; x++) {
      for (int y = 1; y < gridSize - 1; y++) {
        double laplacian = (inkGrid[x - 1][y] +
                inkGrid[x + 1][y] +
                inkGrid[x][y - 1] +
                inkGrid[x][y + 1] -
                4 * inkGrid[x][y]) *
            diffusionRate;

        newGrid[x][y] = inkGrid[x][y] +
            laplacian -
            (inkGrid[x][y] * inkGrid[x][y] * inkGrid[x][y]) +
            (feedRate * (1 - inkGrid[x][y]));
      }
    }
    inkGrid = newGrid;
  }

  @override
  void render(Canvas canvas) {
    Paint inkPaint = Paint()..color = Colors.black;
    double cellSize = size.x / gridSize;

    for (int x = 0; x < gridSize; x++) {
      for (int y = 0; y < gridSize; y++) {
        if (inkGrid[x][y] > 0.01) {
          inkPaint.color = Colors.black.withOpacity(inkGrid[x][y]);
          canvas.drawRect(
              Rect.fromLTWH(x * cellSize, y * cellSize, cellSize, cellSize),
              inkPaint);
        }
      }
    }
  }

}
