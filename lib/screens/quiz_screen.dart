import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quiz_test/utils/color/app_color.dart';
import 'package:quiz_test/utils/helper/shared_prefs_manager.dart';
import 'package:quiz_test/utils/values/app_constants.dart';

import '../data/model/quiz_model.dart';
import '../data/presenter/quiz_presenter.dart';
import '../utils/helper/helper.dart';
import '../utils/helper/util_functionality.dart';
import '../utils/helper/util_views.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  late QuizModel quizModel;
  int quizIndex = 0;
  int currentScore = 0;
  int highScore = 0;

  @override
  void initState(){
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      highScore= await SharedPrefManager.getHighScore();
      _initQuizLoad();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.green,
        title: Text(AppConstant.appName,style: TextStyle(color: AppColor.white),
        ),
        centerTitle: true,

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Your Score: ${currentScore}',style: TextStyle(color: AppColor.white)),
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: quizModel.questions.length,
            itemBuilder: (context,index){
              return questionBackgroundUi(
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      questionNumberAndScoreUi(index,quizModel.questions.length,quizModel.questions[index].score),
                      questionImageUi(quizModel.questions[index].questionImageUrl!,AppConstant.assetImagePath+AppConstant.placeholderImagePath),
                      questionUi(quizModel.questions[index].question),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: quizModel.questions[index].answers.answerMap!.entries.map((e) => Card(
                          //color: ,
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                if(e.key==quizModel.questions[index].correctAnswer){
                                  currentScore+=int.parse(quizModel.questions[index].score);
                                  //print('Current score:$currentScore');
                                }
                                if(index==quizModel.questions.length-1){
                                  if(highScore<currentScore){
                                    SharedPrefManager.setHighScore(currentScore);
                                    widgetSnackBar(context,AppConstant.congorMsg);
                                  }
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${e.key}: ${e.value}',),
                            ),
                          ),
                        )).toList(),),
                    ],
                  )
              );
            }),
      ),
    );
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

  Widget questionNumberAndScoreUi(int index,int questionLength,String questionScore){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Score: $questionScore'),
        Text('${index+1}/$questionLength'),
      ],
    );
  }

  Widget questionImageUi(String imageUrl,String placeholderPath){
    return SizedBox(
      height: 70,width: MediaQuery.of(context).size.width-20,
      child: FadeInImage(
          placeholder: AssetImage(placeholderPath),
          image: NetworkImage(imageUrl),
          imageErrorBuilder:
              (context, error, stackTrace) =>Image.asset(placeholderPath),
          fit: BoxFit.fitWidth
      ),
    );
  }

  Widget questionUi(String question){
    return Text('Q: $question',style: TextStyle(fontSize: 20,),maxLines: 2,);
  }

  Widget questionBackgroundUi(Widget child){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      width: double.infinity,
      height: MediaQuery.of(context).size.width-10,
      //color: Colors.red,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: AssetImage(AppConstant.assetImagePath+AppConstant.backgroundImagePath),fit: BoxFit.fill)
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

}
