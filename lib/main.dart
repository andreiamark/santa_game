import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:santa_game/games/gift_grab_game.dart';

import 'main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: MainMenu()),
  );
}
