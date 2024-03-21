
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quiz_test/utils/values/app_constants.dart';

import '../utils/color/app_color.dart';
import '../utils/helper/shared_prefs_manager.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  int score;
  HomeScreen({super.key,required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            tittleOfTheAppUi(),
            startNewGameButtonUi(context),
            highestScoreUi()
          ],
        ),
      ),
    );
  }

  Widget tittleOfTheAppUi(){
    return Text(AppConstant.appName);
  }

  Widget startNewGameButtonUi(BuildContext context){
    return ElevatedButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizScreen()));
    }, child: Text('Start New Game'));
  }

  Widget highestScoreUi(){
    return Text('Highest Score: $score');
  }
}