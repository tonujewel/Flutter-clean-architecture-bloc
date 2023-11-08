import 'dart:io';

String fixture(String fileName) =>
    File("test/fixures/user.json").readAsStringSync();
