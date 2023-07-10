import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvvm/model/UserModel.dart';
import 'package:mvvvm/repository/auth_respository.dart';
import 'package:mvvvm/utilis/routes/routes_name.dart';
import 'package:mvvvm/utilis/utilis.dart';
import 'package:mvvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier{

  final _myRespo = AuthRepository();

  bool _loading = false;

  bool _signuploading = false;

  bool get loading => _loading;

  bool get signuploading => _signuploading;

  setloading(bool value){

    _loading = value;
    notifyListeners();

  }

  setsignuploading(bool value){

    _signuploading = value;
    notifyListeners();

  }

  Future<void> loginApi(dynamic data, BuildContext context) async{

    setloading(true);

    _myRespo.loginApi(data).then((value) {
      setloading(false);
      final userPreference = Provider.of<UserViewModel>(context, listen: false);

      userPreference.saveUser(
        UserModel(

          token: value['token'].toString()

        )

      );

      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){

        print(value.toString());

      }


    }).onError((error, stackTrace) {

      setloading(false);

      if(kDebugMode){

        print(error.toString());
      }

    });


}

  Future<void> RegisterApi(dynamic data, BuildContext context) async{

    setsignuploading(true);

    _myRespo.registerApi(data).then((value) {
      setsignuploading(false);
      Utilis.flushBarErrorMessage("Register Successfull", context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){

        print(value.toString());

      }


    }).onError((error, stackTrace) {

      setsignuploading(false);

      if(kDebugMode){

        print(error.toString());
      }

    });


  }

}