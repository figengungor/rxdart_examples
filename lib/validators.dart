import 'dart:async';

import 'package:rxdart_examples/validator_errors.dart';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (String email, EventSink<String> sink) {
      if (RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError(ValidatorErrors.invalidEmail);
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (String password, EventSink<String> sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError(ValidatorErrors.invalidPassword);
    }
  });
}
