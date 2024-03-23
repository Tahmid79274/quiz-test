
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quiz_test/data/model/quiz_model.dart';
import 'package:quiz_test/utils/values/app_constants.dart';

import '../data/presenter/quiz_presenter.dart';
import '../utils/color/app_color.dart';
import '../utils/helper/helper.dart';
import '../utils/helper/shared_prefs_manager.dart';
import '../utils/helper/util_views.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late QuizModel quizModel;
  int highScore = 0 ;
  @override
  void initState(){
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _initQuizLoad();
    });
    super.initState();
    fetchHighScore();
  }

  void fetchHighScore() async {
    int newHighScore = await SharedPrefManager.getHighScore();
    setState(() {
      highScore = newHighScore;
    });
  }

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
      Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizScreen(quizModel: quizModel,)));
    }, child: Text('Start New Game'));
  }

  Widget highestScoreUi(){
    return Text('Highest Score: $highScore');
  }

  Future<void> _initQuizLoad() async {
    try {
      showLoader(context, AppConstant.loaderMsg);

      var quizInfo = await initQuizInfo();
      print("");

      stopLoader(context);

      if (quizInfo is String) {
        print("");
        widgetErrorSnackBar(context, quizInfo);
      } else {
        quizModel = quizInfo;
        print('');

        setState(() {
          quizModel;
        });
      }

      print('');
    } catch (e) {
      print(e);
    }
  }
}