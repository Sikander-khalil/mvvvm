import 'package:flutter/foundation.dart';
import 'package:mvvvm/data/response/api_response.dart';
import 'package:mvvvm/model/movies_model.dart';
import 'package:mvvvm/repository/home_repository.dart';

class HomeViewModel with ChangeNotifier{


  final _myRep = HomeRepository();

  ApiReponse<MOVIES> moviesList = ApiReponse.loading();

  setMoviesList(ApiReponse<MOVIES> response ){

    moviesList = response;

    notifyListeners();

  }

  Future<void> fetchMoviesListApi() async{

    setMoviesList(ApiReponse.loading());

    _myRep.fetchMoviesList().then((value) {

      setMoviesList(ApiReponse.completed(value));



    }).onError((error, stackTrace) {

      setMoviesList(ApiReponse.error(error.toString()));



    });
  }




}