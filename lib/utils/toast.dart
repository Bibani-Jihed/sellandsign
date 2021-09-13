import 'package:fluttertoast/fluttertoast.dart';

class MyToast{
  MyToast._();


  static void showToast(message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }
}