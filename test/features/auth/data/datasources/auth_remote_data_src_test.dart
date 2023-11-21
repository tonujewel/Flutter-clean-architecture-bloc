import 'dart:convert';

import 'package:clean_architecute_bloc/core/errors/exceptions.dart';
import 'package:clean_architecute_bloc/core/utils/constant.dart';
import 'package:clean_architecute_bloc/features/auth/data/datasources/auth_remote_data_src.dart';
import 'package:clean_architecute_bloc/features/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthRemoteDataSrc remoteDataSrc;

  setUp(() {
    client = MockClient();
    remoteDataSrc = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group("createUser", () {
    test("should complete succesfully when the status code is 200 or 201", () async {
      when(() => client.post(any(), body: any(named: "body"))).thenAnswer(
        (_) async => http.Response("User created successfully", 201),
      );

      final methodCall = remoteDataSrc.createUser;

      expect(
        methodCall(createdAt: "createdAt", name: "name", avatar: "avatar"),
        completes,
      );

      verify(
        () => client.post(
          Uri.parse("$kBaseUrl$kCreateUserEndPoint"),
          body: jsonEncode({"createdAt": "createdAt", "name": "name", "avatar": "avatar"}),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test("should throw [APIException] when status code is not 200 or 201", () async {
      when(() => client.post(any(), body: any(named: "body"))).thenAnswer(
        (_) async => http.Response("User creation failed", 505),
      );

      final methodCall = remoteDataSrc.createUser;

      expect(
          () => methodCall(createdAt: "createdAt", name: "name", avatar: "avatar"),
          throwsA(
            const ApiException(message: "User creation failed", statusCode: 505),
          ));

      verify(
        () => client.post(
          Uri.parse("$kBaseUrl$kCreateUserEndPoint"),
          body: jsonEncode({"createdAt": "createdAt", "name": "name", "avatar": "avatar"}),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group("getUsers", () {
    const tUser = [UserModel.empty()];

    test("should return [List<User>] when the status code is 200", () async {
      when(
        () => client.get(any()),
      ).thenAnswer((_) async => http.Response(jsonEncode([tUser.first.toMap()]), 200));

      final result = await remoteDataSrc.getUsers();
      expect(result, equals(tUser));

      verify(
        () => client.get(Uri.parse(kBaseUrl + kGetUsersEndPoint)),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test("should throw [APIException] when status code is not 200", () async {
      const tMsg = "Server Down";
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(tMsg, 500),
      );

      final methodCall = remoteDataSrc.getUsers;

      expect(
        methodCall,
        throwsA(
          const ApiException(message: tMsg, statusCode: 500),
        ),
      );

      verify(() => client.get(Uri.parse(kBaseUrl + kGetUsersEndPoint))).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
