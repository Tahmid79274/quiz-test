
import 'package:flutter/material.dart';
import 'package:quiz_test/utils/values/app_constants.dart';

import '../utils/color/app_color.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            higestScoreUi()
          ],
        ),
      ),
    );
  }
}

Widget tittleOfTheAppUi(){
  return Text(AppConstant.appName);
}

Widget startNewGameButtonUi(BuildContext context){
  return ElevatedButton(onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizScreen()));
  }, child: Text('Start New Game'));
}

Widget higestScoreUi(){
  return Text('Highest Score: 0');
}