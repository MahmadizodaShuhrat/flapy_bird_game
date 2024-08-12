import 'package:flutter/material.dart';
import 'package:game/game/assets.dart';
import 'package:game/game/flappy_bird_game.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = 'gameOver';

  const GameOverScreen({super.key, required this.game});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
                'Score: ${game.bird.score}',
                style: const TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontFamily: 'Game',
                ),
              ),
              const SizedBox(height: 20),
          Image.asset(Assets.gameover),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: onRestart,
              child:const Text(
                'Restart',
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
  void onRestart(){
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}