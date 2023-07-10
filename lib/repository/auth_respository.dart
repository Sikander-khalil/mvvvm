import 'package:mvvvm/data/network/BaseApiService.dart';
import 'package:mvvvm/data/network/NetworkApiService.dart';
import 'package:mvvvm/res/app_url.dart';

class AuthRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async{

    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);

      return response;




    }catch(e){

      throw e;
    }
  }


  Future<dynamic> registerApi(dynamic data) async{

    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerApiEndPoint, data);

      return response;




    }catch(e){

      throw e;
    }
  }



}