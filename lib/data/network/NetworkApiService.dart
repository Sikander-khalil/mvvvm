import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mvvvm/data/app_exceptions.dart';
import 'package:mvvvm/data/network/BaseApiService.dart';
import 'package:http/http.dart' as http;
class NetworkApiServices extends BaseApiServices{
  @override
  Future getGetApiResponse(String url) async{

    dynamic responseJson;

    try{
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      responseJson = returnResponse(response);


    }on SocketException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async{
    dynamic responseJson;

    try{
    Response response = await post(
      Uri.parse(url),

      body: data
    ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);


    }on SocketException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse (http.Response response){

    switch(response.statusCode){

      case 200:
      dynamic responseJson = jsonDecode(response.body);

      return responseJson;

      case 400:
        throw BadRequestException(response.body.toString());
        case 404:
        throw UnauthorizedException(response.body.toString());

      default:
        throw FetchDataException("Error occured while communication with server"+ response.statusCode.toString());


    }
  }
  
  
  
  
}