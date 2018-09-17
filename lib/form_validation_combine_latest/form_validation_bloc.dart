import 'dart:async';
import 'package:rxdart/rxdart.dart';

class FormValidationBloc {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  //Output Streams
  Stream<String> get email => _email.stream;

  Stream<String> get password => _password.stream;

  //combineLatest =>
  // Merges the given Streams into one Observable sequence by using the
  // [combiner] function whenever any of the observable sequences emits an
  // item.
  //
  // The Observable will not emit until all streams have emitted at least one
  // item.
  //

  //USE CASE:
  //In this use case, need to disable submitButton initially when there is no
  //data, so start _email and _password streams with empty string
  //knowing that they won't pass validation and return false.

  //Also, check empty values before adding error, don't want to show
  //error to user before user gives some input.

  //Enable submitButton only when both fields pass the validation.

  Stream<bool> get isSubmitValid =>
      Observable.combineLatest2(_email.startWith(''), _password.startWith(''),
          (String e, String p) {
        final bool isEmailValid = RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(e);
        final bool isPasswordValid = p.length >= 6;

        if (!isEmailValid && e.isNotEmpty) {
          _email.sink.addError('Invalid email');
        }
        if (!isPasswordValid && p.isNotEmpty) {
          _password.sink
              .addError('Invalid password: must be at least 6 characters');
        }

        return isEmailValid && isPasswordValid;
      });

  //Input Functions
  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    print('Email is $validEmail');
    print('Password is $validPassword');
  }

  dispose() {
    _email.close();
    _password.close();
  }
}
