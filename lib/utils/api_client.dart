import 'dart:convert';

import 'package:Test_Flutter_Developer_Sneakershoot/models/popular_movies.dart';
import 'package:Test_Flutter_Developer_Sneakershoot/utils/api_provider.dart';
import 'package:Test_Flutter_Developer_Sneakershoot/utils/constant.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static Future<PopularMovies> popularMoviesList({int page = 1}) async{
    var dio = ApiProvider.init();
    Map<String,dynamic> param = {
      "api_key":Constant.apiKey,
      "page":page
    };
    Response response = await dio.get("movie/popular",queryParameters: param);
    if (response.statusCode == 200) {
      return PopularMovies.fromJson(response.data);
    }
    return PopularMovies.fromJson(jsonDecode("{}"));
  }
}