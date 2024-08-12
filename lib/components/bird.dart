import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/widgets.dart';
import 'package:game/game/assets.dart';
import 'package:game/game/bird_movement.dart';
import 'package:game/game/config.dart';
import 'package:game/game/flappy_bird_game.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Bird();

 int score = 0;

  @override
  Future<void> onLoad() async {
    final birdMidflap = await gameRef.loadSprite(Assets.birdMidflap);
    final birdUppflap = await gameRef.loadSprite(Assets.birdUppflap);
    final birdDownflap = await gameRef.loadSprite(Assets.birdDownflap);

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = BirdMovement.middle;
    sprites = {
      BirdMovement.middle: birdMidflap,
      BirdMovement.up: birdUppflap,
      BirdMovement.down: birdDownflap,
   
    };
  
  add(CircleHitbox());
  }


  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.birdVelocity * dt;
    if (position.y < 1) {
      gameOver();
    }
  }


  void fly() {
    add(MoveByEffect(
      Vector2(0, Config.gravity),
      EffectController(duration: 0.2, curve: Curves.decelerate),
      onComplete: () => current = BirdMovement.down,
    ));
    current = BirdMovement.up;
    FlameAudio.play(Assets.flying);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
gameOver();
  }

void reset(){
  position = Vector2(50, gameRef.size.y / 2 -size.y / 2);
  score = 0;
}


void gameOver(){
  FlameAudio.play(Assets.colission);
  gameRef.overlays.add('gameOver');
  gameRef.pauseEngine();
  game.isHit = true;

}



}
