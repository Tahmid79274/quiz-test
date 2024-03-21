import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quiz_test/utils/color/app_color.dart';
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

  @override
  void initState(){
    SchedulerBinding.instance.addPostFrameCallback((_) async {
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
          Text('Your Score: ${currentScore}',style: TextStyle(color: AppColor.white))
        ],
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: ListView.builder(
            shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: quizModel.questions.length,
              itemBuilder: (context,index){
                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width-10,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        if (quizIndex<quizModel.questions.length) {
                          quizIndex++;
                        } else {
                          quizIndex=0;
                        }
                      });
                    },
                    child: Visibility(
                      visible: quizIndex==index,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Score: ${quizModel.questions[index].score}'),
                                Text('${index+1}/${quizModel.questions.length}'),
                              ],
                            ),
                          Text('Q: ${quizModel.questions[index].question}'),
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
                      ),
                    ),
                  ),
                );
              }),
        ),
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

}
