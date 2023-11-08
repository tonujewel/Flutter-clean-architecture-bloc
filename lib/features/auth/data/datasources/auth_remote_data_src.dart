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

class AuthRemoteDataSrcImpl implements AuthRemoteDataSrc {
  final http.Client _client;

  const AuthRemoteDataSrcImpl(this._client);

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
