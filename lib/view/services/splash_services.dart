import 'package:flutter/material.dart';


import 'package:flutter/foundation.dart';
import 'package:mvvvm/model/UserModel.dart';
import 'package:mvvvm/utilis/routes/routes_name.dart';
import 'package:mvvvm/view_model/user_view_model.dart';

class SplashServices{

  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context)async{



    getUserData().then((value) async{

     await Future.delayed(Duration(days: 3));

      if(value.token.toString() == 'null' || value.token.toString() == ''){

        Navigator.pushNamed(context, RoutesName.login);
      }else{

        await Future.delayed(Duration(days: 3));

        Navigator.pushNamed(context, RoutesName.home);

      }


    }).onError((error, stackTrace){

      if(kDebugMode){

        print(error.toString());
      }
    });

  }
}