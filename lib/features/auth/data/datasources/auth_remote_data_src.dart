import 'dart:convert';
import 'dart:developer';

import 'package:clean_architecute_bloc/core/errors/exceptions.dart';
import 'package:clean_architecute_bloc/core/utils/constant.dart';
import 'package:clean_architecute_bloc/core/utils/typedef.dart';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSrc {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndPoint = "/user";
const kGetUsersEndPoint = "/user";

class AuthRemoteDataSrcImpl implements AuthRemoteDataSrc {
  final http.Client _client;

  const AuthRemoteDataSrcImpl(this._client);

  @override
  Future<void> createUser(
      {required String createdAt, required String name, required String avatar}) async {
    // check to make sure thay it returns the right data when the response code is 200 or the proper response code
    // check to make sure that it "THROWS A CUSTOM EXCEPTION" with the right msg when status code the bad one.

    try {
      final response = await _client.post(
        Uri.parse("$kBaseUrl$kCreateUserEndPoint"),
        body: jsonEncode(
          {"createdAt": createdAt, "name": name, "avatar": avatar},
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(message: response.body, statusCode: response.statusCode);
      }
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final result = await _client.get(Uri.parse(kBaseUrl + kGetUsersEndPoint));

    log("message ${result.toString()}");

    return List<DataMap>.from(jsonDecode(result.body) as List)
        .map((userData) => UserModel.fromMap(userData))
        .toList();
  }
}
