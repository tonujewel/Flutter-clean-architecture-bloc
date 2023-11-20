import 'dart:convert';

import 'package:clean_architecute_bloc/core/errors/exceptions.dart';
import 'package:clean_architecute_bloc/core/utils/constant.dart';
import 'package:clean_architecute_bloc/features/auth/data/datasources/auth_remote_data_src.dart';
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
        (_) async => http.Response("User creation failed", 400),
      );

      final methodCall = remoteDataSrc.createUser;

      expect(
          () async => methodCall(createdAt: "createdAt", name: "name", avatar: "avatar"),
          throwsA(
            const ApiException(message: "User creation failed", statusCode: 400),
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
}
