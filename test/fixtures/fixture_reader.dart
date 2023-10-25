import 'dart:io';

String fixture(String filename) =>
    File('test/fixtures/$filename').readAsStringSync();
