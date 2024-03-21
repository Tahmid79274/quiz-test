import 'dart:convert';

import '../../network/client/base_client.dart';
import '../../network/service/service.dart';
import '../../utils/helper/util_functionality.dart';
import '../../utils/values/app_constants.dart';
import '../model/quiz_model.dart';

Future<dynamic> initQuizInfo() async {
  String url = Service.quizUrl;

  var response = await BaseClient().getMethod(url);

  if (response != null) {
    try {
      QuizModel quizModel =
      QuizModel.fromJson(json.decode(response));

      return quizModel;
    } catch (e) {
      return UtilFunctionality.showErrorMsg(response);
    }
  } else {
    return AppConstant.errorMsg;
  }
}