import 'package:flutter/material.dart';

import '../values/app_constants.dart';

widgetSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 3),
        content: Text(
          msg,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
  );
}

widgetErrorSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        content: Text(
          msg,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
  );
}