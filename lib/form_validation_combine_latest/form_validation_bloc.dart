import 'dart:async';
import 'package:rxdart/rxdart.dart';

class FormValidationBloc{

  final _email = BehaviorSubject<String>(seedValue: '');
  final _password = BehaviorSubject<String>(seedValue: '');

  //Output Streams
  Stream<String> get email => _email.stream;
  Stream<String> get password => _password.stream;
  Stream<bool> get isSubmitValid =>
    Observable.combineLatest2(_email, _password, (String e, String p) {

      final bool isEmailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(e);
      final bool isPasswordValid = p.length >= 6;

      if(!isEmailValid && e.isNotEmpty){
        _email.sink.addError('Invalid email');
      }
      if(!isPasswordValid && p.isNotEmpty){
        _password.sink.addError('Invalid password');
      }
      print(isEmailValid && isPasswordValid);
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
