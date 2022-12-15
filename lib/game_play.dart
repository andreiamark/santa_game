import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:santa_game/game_over_menu.dart';
import 'package:santa_game/games/gift_grab_game.dart';


final GiftGrabGame _giftGrabGame = GiftGrabGame();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _giftGrabGame,
      overlayBuilderMap: {
        GameOverMenu.ID: (BuildContext context, GiftGrabGame gameRef) =>
        GameOverMenu(gameRef: gameRef),
      }
    );
  }
}
