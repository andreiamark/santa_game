import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import '../constants/globals.dart';
import '../games/gift_grab_game.dart';
import 'ice-component.dart';

enum MovementState{
  idle,
  slideLeft,
  slideRight,
  frozen
}

class SantaComponent extends SpriteGroupComponent<MovementState>
    with HasGameRef<GiftGrabGame>, CollisionCallbacks{
  final double _spriteHeight = 200;
  final double _speed = 500;

  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

  JoystickComponent joystick;

  bool _frozen = false;

  final Timer _timer = Timer(3);

  SantaComponent({required this.joystick});

  @override
  Future<void> onLoad() async{
    await super.onLoad();

    Sprite santaIdle  = await gameRef.loadSprite(Globals.santaIdleSprite);
    Sprite santaLeftSlide  = await gameRef.loadSprite(Globals.santaLeftSprite);
    Sprite santaRightSlide  = await gameRef.loadSprite(Globals.santaRightSprite);
    Sprite santaFrozen = await gameRef.loadSprite(Globals.santaLeftSprite);
      sprites = {
        MovementState.idle: santaIdle,
        MovementState.slideLeft: santaLeftSlide,
        MovementState.slideRight: santaRightSlide,
        MovementState.frozen: santaFrozen,
    };

      // _rightBound = gameRef.size.x - 45;
      // _leftBound = 45;
      // _upBound = 55;
      // _downBound = gameRef.size.y - 85;

    _rightBound = gameRef.size.x - 20;
    _leftBound = 40;
    _upBound = 40;
    _downBound = gameRef.size.y - 60;

      current = MovementState.idle;

    position = gameRef.size / 2;
    height = _spriteHeight * 0.7;
    width = _spriteHeight * 0.4;
    anchor = Anchor.center;
    add(CircleHitbox());
  }

  @override
  void update(dt) {
    super.update(dt);
    if(!_frozen){
      if (joystick.direction == JoystickDirection.idle){
        current = MovementState.idle;
        return;
      }

      if( x >= _rightBound) {
        x = _rightBound - 1;
      }

      if( x <= _leftBound) {

        x = _leftBound + 1;
      }

      if( y <= _upBound) {
        y = _upBound + 1;
      }

      if( y >= _downBound) {
        y = _downBound - 1;
      }

      bool movingLeft = joystick.relativeDelta[0] < 0;

      if(movingLeft) {
        current = MovementState.slideLeft;
      } else {
        current = MovementState.slideRight;
      }
      position.add(joystick.relativeDelta * _speed * dt);
    } else {
      _timer.update(dt);
      if(_timer.finished){
        _unfreezeSanta();
      }
    }
  }
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    {
      if (other is IceComponent) {
        _freezeSanta();
      }
    }
  }
    void _unfreezeSanta() {
      _frozen = false;
      current = MovementState.idle;
    }

    void _freezeSanta() {
      if(!_frozen) {
        FlameAudio.play(Globals.freezeSprite);

        _frozen = true;

        current = MovementState.frozen;

        _timer.start();
      }
    }
  }
