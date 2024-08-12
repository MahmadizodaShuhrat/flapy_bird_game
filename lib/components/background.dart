import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:game/game/assets.dart';
import 'package:game/game/flappy_bird_game.dart';
import 'dart:async';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(Assets.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}