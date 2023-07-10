import 'package:flutter/material.dart';
import 'package:mvvvm/utilis/routes/routes_name.dart';
import 'package:mvvvm/view/home_screen.dart';
import 'package:mvvvm/view/login_screen.dart';
import 'package:mvvvm/view/signup_view.dart';

import '../../view/Splash_Screen.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginScreen());

      case RoutesName.signup:
        return MaterialPageRoute(builder: (BuildContext context) => const SignupView());

      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());


      default:

        return MaterialPageRoute(builder: (_){

          return const Scaffold(
            body: Text("No Routes Defined"),
          );


        });
    }
  }
}