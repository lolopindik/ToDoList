// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:uuid/uuid.dart';

class ID {
  var uuid = Uuid();

  String generateUuid() {
    return uuid.v1();
  }
}

abstract class SubID extends ID {
  void printUuid();
}

class ConcreteSubID extends SubID {
  @override
  void printUuid() {
    print('Genereted ID: ${generateUuid()}');
  }
}