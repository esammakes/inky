import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'fluid_simulation.dart';

class InkyGame extends FlameGame with TapCallbacks {
  late FluidSimulation fluidSim;

  @override
  Color backgroundColor() => Colors.orangeAccent; // Match target look

  @override
  Future<void> onLoad() async {
    fluidSim = FluidSimulation();
    fluidSim.size = size; // Ensure it covers the entire screen
    fluidSim.position = Vector2.zero(); // Ensure it starts at (0,0)

    print("Fluid Simulation Loaded: ${fluidSim.size}"); // Debugging
    add(fluidSim);
  }

  @override
  void onTapDown(TapDownEvent event) {
    final position = event.localPosition;
    print("Tapped at: ${position.x}, ${position.y}"); // Debugging
    fluidSim.addInk(position);
  }
}
