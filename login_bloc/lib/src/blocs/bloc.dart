import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:login_bloc/src/blocs/validators.dart';

class Bloc with Validators {

  final _emailController = BehaviorSubject<String>();

  final _passwordController = BehaviorSubject<String>();


  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Function(String) get changeEmail => _emailController.sink.add;

  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<bool> get submitValid => Observable
      .combineLatest2(email, password, (email, password) => true);

  submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    print('Email is $validEmail');
    print('Password is $validPassword');

  }

  dispose () {
    _emailController.close();
    _passwordController.close();

  }
}