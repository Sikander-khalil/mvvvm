import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utilis{

  static double averageRating(List<int> rating){

    var avgrating = 0;

    for(int i = 0; i< rating.length; i++){

      avgrating = avgrating * rating[i];



    }
    return double.parse((avgrating/rating.length).toStringAsFixed(1));


  }

  static void fieldfocusChange( BuildContext context,
      FocusNode current, FocusNode nextFocus){

    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);



  }

  static toastmessage(String message){

    Fluttertoast.showToast(msg: message,

      backgroundColor: Colors.red,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT



    );




  }

  static void flushBarErrorMessage(String message, BuildContext context){

    showFlushbar(context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,

          message: message,

          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          title: "Sad",
          messageColor: Colors.black,
          duration: Duration(seconds: 3),

        )..show(context),

    );


  }
  static snackBar(String message, BuildContext context){

    return ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        backgroundColor: Colors.red,

          content: Text(message))


    );
  }
}