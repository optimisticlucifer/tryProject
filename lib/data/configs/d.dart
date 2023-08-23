import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';

class DI {
  static final DI _singleton = DI._internal();

  late Dio dio;
  factory DI() {
    return _singleton;
  }

  DI._internal() {
    BaseOptions options = BaseOptions(
      // only dev url for now
        // baseUrl: "https://cy8d8jgj2g.execute-api.us-east-1.amazonaws.com/prod");
        baseUrl: "https://ujdu1ty7bh.execute-api.us-east-1.amazonaws.com/prod/");

    options.connectTimeout = 70000;
    options.receiveTimeout = 70000;
    dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, _handler) async {
        print("${options.method} ${options.path}");
        options.headers['Authorization'] = token;
        // options.headers['X-Ode-AppOrigin'] = "datacoup";
        options.contentType = Headers.jsonContentType;

        return _handler.next(options);
      },
      onResponse: (Response response, _handler) {
        // print(response.statusCode);
        return _handler.resolve(response);
      },
      onError: (DioError e, _handler) async {
        print("API Error response: ");
        print("This is the error ${e.error}");

        return _handler.reject(e);
      },
    ));
  }
}

// to get token..

String token =
    "eyJraWQiOiJmS1hDZllUMUxuRGRGbmFweW5Da3V6bXc3TmhkYlhXTUFkcHZIVkVWQWNzPSIsImFsZyI6IlJTMjU2In0.eyJvcmlnaW5fanRpIjoiNzFiNTVhYjAtYTk4Ny00NjViLWI5MWItZTgyMDRjMTg2ZTljIiwic3ViIjoiMDJiZWI4NWYtNTAxOS00ZjNmLTljMDAtYzdhOWU2MzJjYTMxIiwiYXVkIjoiM2FwdGg1a3I2NnQybzQ3cmY3bTN0b2pnMXQiLCJldmVudF9pZCI6IjQxYTRmYWM3LTE2MWYtNDQ3OC1iMDEwLTMzZDU2ZGU1ZGQ2OCIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNjc5MDY1NTg2LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtZWFzdC0xLmFtYXpvbmF3cy5jb21cL3VzLWVhc3QtMV85dlR4MDBBUFIiLCJjb2duaXRvOnVzZXJuYW1lIjoiZGNfYWRtaW5AeW9wbWFpbC5jb20iLCJleHAiOjE2NzkwNjkxODYsImlhdCI6MTY3OTA2NTU4NiwianRpIjoiMTIzM2ZlMjctNzY1YS00MmRlLWE3YWEtZjU0YWExOTRlZWZmIn0.c_7SeXJgRJZvbvqekxVgiFmsKfk-O5gKymrfogPZ1k95FeJDFC8raVLXDv5WEn5Iz2i9ATdqagFgt4gd_la9kY71qP9fFeSd_3fqTNK1TRMS_RE1vbjH2u7J9pRZaCOOA_Bvapjs7E2t_1k-5LhIzPsPamE2dRHYuUtQxbulgKGUMH7lBMgKiXNytC9bAiVhSuSimDKr7FCccbaQ9m6yknGHdgnsKIc56NIjKloClr7_mntyRZJXKoyajdIADk1ocg0grrn67o_meePioM5VvzWf4-JS8sAqGCkOOiDX1Dy4Q2VhVtoC5o8uWRe5hrl3nm_hI4FrB0feyXlByemJjQ";
