import 'dart:convert';
import 'package:Test_Flutter_Developer_Sneakershoot/utils/constant.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  static const CORE_URL = "https://api.themoviedb.org/3/";
  static const BASE_URL = "$CORE_URL";
  static Dio init({String contentType = "application/json"}){
    Dio dio = new Dio(new BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      headers: {
        "Content-Type": contentType,
        // 'Authorization': Constant.apiToken
        },
    ));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:(RequestOptions options){
        return options; //continue
        },
        onResponse:(Response response) {
        return response; // continue
        },
        onError: (DioError e) {
        print("DIO ERROR");
        print(e);
        return  e;//continue
        }
      )
    );

    return dio;
  }
}
