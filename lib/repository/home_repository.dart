import 'package:mvvvm/data/network/BaseApiService.dart';
import 'package:mvvvm/data/network/NetworkApiService.dart';
import 'package:mvvvm/model/movies_model.dart';

import '../res/app_url.dart';

class HomeRepository{

  BaseApiServices  _apiServices = NetworkApiServices();


  Future<dynamic> fetchMoviesList() async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesEndPoint);

      return response = MOVIES.fromJson(response);




    }catch(e){

      throw e;
    }
  }



}