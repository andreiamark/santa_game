import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:santa_game/component/background_component.dart';
import 'package:santa_game/component/gift_component.dart';
import 'package:santa_game/component/ice-component.dart';
import 'package:santa_game/constants/globals.dart';
import 'package:santa_game/inputs/joystick.dart';
import 'package:flutter/material.dart';
import '../component/santa_component.dart';
import '../game_over_menu.dart';

class GiftGrabGame extends FlameGame with HasDraggables, HasCollisionDetection{
  int score = 0;

  late Timer _timer;

  int _remainingTime = 30;

  late TextComponent _scoreText;

  late TextComponent _time;

  @override
  Future<void> onLoad() async {
  await super.onLoad();

  add(BackgroundComponent());
  add(SantaComponent(joystick: joystick));
  add(joystick);
  add(GiftComponent());
  FlameAudio.audioCache.loadAll(
    [Globals.itemGrabSound,
    Globals.freezeSprite],
  );
  add(IceComponent(
    startPosition: Vector2(200,200)
  ));
  add(IceComponent(
      startPosition: Vector2(size.x - 200, size.y - 200)
  ));
  add(ScreenHitbox());

  _scoreText = TextComponent(
      text: "Score: $score",
  position: Vector2(40,40),
  anchor: Anchor.topLeft,
  textRenderer: TextPaint(
      style: TextStyle(
        color: BasicPalette.white.color,
      fontSize: 20,)));

  add(_scoreText);

  _time = TextComponent(
      text: "Time: $_remainingTime seconds",
      position: Vector2(size.x- 40,40),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
          style: TextStyle(
            color: BasicPalette.white.color,
            fontSize: 20,)));

  add(_time);

  _timer = Timer(
    1,
    repeat:true,
    onTick:  () {
      if(_remainingTime == 0){
          pauseEngine();
          overlays.add(GameOverMenu.ID);
      } else {
        _remainingTime -= 1;
      }
    }
  );
   _timer.start();

}

@override
  void update(dt) {
  super.update(dt);
  _timer.update(dt);

  _scoreText.text = "Score: $score";

  _time.text = "Time: $_remainingTime seconds";
 }
 void reset() {
    score = 0;
    _remainingTime = 30;
 }


}