import 'package:flutter/material.dart';

import 'constants/globals.dart';
import 'game_play.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

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
                      'Gift Grab',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                ),

                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) =>  GamePlay(),
                      )
                    );
                    },
                    child: Text(
                        'Play ',
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

