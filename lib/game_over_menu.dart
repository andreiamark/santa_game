import 'package:flutter/material.dart';

import 'constants/globals.dart';
import 'games/gift_grab_game.dart';

class GameOverMenu extends StatelessWidget {

  static const String ID = "GameOverMenu";
  final GiftGrabGame gameRef;

  const GameOverMenu({Key? key,
    required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/${Globals.backgroundSprite}"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                )
              ),
              Padding(padding: EdgeInsets.symmetric(vertical:50),
                  child: Text("Score: ${gameRef.score}",
                  style: TextStyle(
                    fontSize: 50,
                  ),
                  ),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    gameRef.overlays.remove(GameOverMenu.ID);
                    gameRef.reset();
                    gameRef.resumeEngine();
                  },
                  child: Text(
                    'Play Again?',
                    style: TextStyle(
                      fontSize: 20,
                    )
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
