import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class FormValidationBloc extends Object with Validators{

  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  //Output Streams
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get isSubmitValid =>
    Observable.combineLatest2(_email, _password, (e, p) => true);

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
