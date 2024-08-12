import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/components/background.dart';
import 'package:game/components/bird.dart';
import 'package:game/components/ground.dart';
import 'package:game/components/pipe_group.dart';
import 'package:game/game/config.dart';


class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();

  late Bird bird;
  late TextComponent score;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      PipeGroup(),
      score = buildScore(),
    ]);

    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
        position: Vector2(size.x / 2, size.y / 2 * 0.2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
            style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontFamily: 'Game',
        )));
  }

  @override
  void onTap() {
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'score: ${bird.score}';
  }
}
