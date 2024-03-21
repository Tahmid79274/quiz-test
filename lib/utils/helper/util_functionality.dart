import 'dart:convert';

import 'package:quiz_test/utils/values/app_constants.dart';

class UtilFunctionality {
  static String showErrorMsg(response) {
    String msg = '';
    try {
      Map<String, dynamic> map = json.decode(response);
      msg = map['message'].toString();
    } catch (e) {
      msg = AppConstant.errorMsg;
    }
    return msg;
  }

  static bool isStringNull(String stringChecker) {
    if (stringChecker == 'null' || stringChecker.isEmpty) {
      return true;
    }else{
      if ((stringChecker == null)) {
        return true;
      } else {
        return false;
      }
    }
  }

  static String stringNullHandler(String stringChecker) {
    if (stringChecker == 'null' || stringChecker.isEmpty) {
      return '';
    }else{
      if ((stringChecker == null)) {
        return '';
      } else {
        return stringChecker;
      }
    }
  }

}
