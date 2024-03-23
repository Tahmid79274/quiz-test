import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quiz_test/screens/home_screen.dart';
import 'package:quiz_test/utils/color/app_color.dart';
import 'package:quiz_test/utils/helper/shared_prefs_manager.dart';
import 'package:quiz_test/utils/values/app_constants.dart';

import '../data/model/quiz_model.dart';
import '../data/presenter/quiz_presenter.dart';
import '../utils/helper/helper.dart';
import '../utils/helper/util_functionality.dart';
import '../utils/helper/util_views.dart';

class QuizScreen extends StatefulWidget {
  QuizModel quizModel;
  QuizScreen({super.key,required this.quizModel});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  //late QuizModel quizModel;
  int quizIndex = 0;
  int currentScore = 0;
  int highScore = 0;

  @override
  void initState(){

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
            itemCount: widget.quizModel.questions.length,
            itemBuilder: (context,index){
              return Visibility(
                visible: index==quizIndex,
                child: questionBackgroundUi(
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        questionNumberAndScoreUi(index,widget.quizModel.questions.length,widget.quizModel.questions[index].score),
                        questionImageUi(widget.quizModel.questions[index].questionImageUrl!,AppConstant.assetImagePath+AppConstant.placeholderImagePath),
                        questionUi(widget.quizModel.questions[index].question),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.quizModel.questions[index].answers.answerMap!.entries.map((e){
                            return Card(
                              //color: ,
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    quizIndex++;
                                    if(e.key==widget.quizModel.questions[index].correctAnswer){
                                      currentScore+=int.parse(widget.quizModel.questions[index].score);
                                      //print('Current score:$currentScore');
                                    }
                                    if(index==widget.quizModel.questions.length-1){
                                      if(highScore<currentScore){
                                        highScore=currentScore;
                                        SharedPrefManager.setHighScore(highScore);
                                        widgetSnackBar(context,AppConstant.congorMsg);
                                      }
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                                    }
                                  });
                                },
                                child: answerOptionUi(e.key,e.value),
                              ),
                            );
                          }).toList(),),
                      ],
                    )
                ),
              );
            }),
      ),
    );
  }



  Widget answerOptionUi(String key,String value){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('$key}: $value',),
    );
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
