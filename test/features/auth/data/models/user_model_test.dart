import 'dart:convert';

import 'package:clean_architecute_bloc/core/utils/typedef.dart';
import 'package:clean_architecute_bloc/features/auth/data/models/user_model.dart';
import 'package:clean_architecute_bloc/features/auth/domain/entities/user_data.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test("should be a sub class of [UserData] entity", () {
    // Assert
    expect(tModel, isA<UserData>());
  });

  final tJson = fixture("user.json");

  final tMap = jsonDecode(tJson) as DataMap;

  group("fromMap", () {
    test("Should return a [fromMap] with the right data", () {
      // Act

      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
      // Assert
    });
  });

  group("fromJson", () {
    test("Should return a [fromJson] with the right data", () {
      // Act

      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
      // Assert
    });
  });

  group("toMap", () {
    test("Should return a [toMap] with the right data", () {
      // Act

      final result = tModel.toMap();
      expect(result, equals(tMap));
      // Assert
    });
  });

  group("toJson", () {
    test("Should return a [toJson] with the right data", () {
      // Act
      final result = tModel.toJson();
      expect(result, equals(tJson));
      // Assert
    });
  });
  group("copyWith", () {
    test("Should return a [copyWith] with the right data", () {
      // Act
      final result = tModel.copyWith(name: "Jewel Rana");
      expect(result.name, equals("Jewel Rana"));
      // Assert
    });
  });
}
