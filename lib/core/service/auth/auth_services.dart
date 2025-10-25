import 'dart:isolate';

import 'package:injectable/injectable.dart';
import '../../networking/api.dart';
import 'user_service_dto.dart';

import '../../../utils/helper/response_helper.dart';

@injectable
class AuthServices {
  final Api _api;

  AuthServices(this._api);

  Future<LoginResponseDto> login({
    required String email,
    required String passWord
  }) async {
    final response = await _api.httpPost(
      endPath: 'auth/login',
      body: {
        'email': email,
        'password': passWord,
      },
    );

    return Isolate.run(
          () {
        final Map<String, dynamic> responseData =
        ResponseChecker.getSuccessData(
          response: response,
        );
        // final Map<String, dynamic> responseData = _loginResponse;

        return LoginResponseDto.fromJson(responseData);
      },
    );
  }

  Future<void> register({
    required String name,
    required String number,
    required String email,
    required String passWord,
    // required String state,
    // required String district,
    // required String locationId,
  }) async {
    await _api.httpPost(
      endPath: 'auth/create',
      body: {
        'email': email,
        'password': passWord,
        'name': name,
        'contact': number,
        // 'state': state,
        // 'district': district,
        // 'locationId': locationId,
      },
    );

  }

  Future<EditProfileResponseDto> editProfile({
    required String name,
    required String email,
    required String number,
    required String dob,
    required String gender,
  }) async {
    final response = await _api.httpPost(
      endPath: '',
      body: {
        'name': name,
        'email': email,
        'number': number,
        'dob': dob,
        'gender': gender,
      },
    );

    return Isolate.run(
          () {
        final Map<String, dynamic> responseData =
        ResponseChecker.getSuccessData(
          response: response,
        );

        return EditProfileResponseDto.fromJson(responseData);
      },
    );
  }
}

final _loginResponse = {
  "success": true,
  "message": "Login Successfull",
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NzljNjI0ZDIwZGU3NmQ1MmU3MDViYWQiLCJpYXQiOjE3MzgzMDMwMzQsImV4cCI6MTczODkwNzgzNH0.pxNTtTDfouFYbNyzNMvWBXRd9zi9_g5e6JjOneLwxJI",
  "data": {
    "userData": {
      "_id": "679c624d20de76d52e705bad",
      "name": "cxfgghfh",
      "contact": 12345678,
      "email": "test123@gmail.com"
    }
  }
};