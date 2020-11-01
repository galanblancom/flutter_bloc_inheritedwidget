import 'dart:async';

class Validators {
  final validarTitle =
      StreamTransformer<String, String>.fromHandlers(handleData: (title, sink) {
    Pattern pattern = r'^[a-zA-Z]{1,20}$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(title)) {
      sink.add(title);
    } else {
      sink.addError('title no es correcto');
    }
  });

  final validarAmount = StreamTransformer<String, String>.fromHandlers(
      handleData: (amount, sink) {
    Pattern pattern = r'^[0-9]{1,5}$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(amount)) {
      sink.add(amount);
    } else {
      sink.addError('amount no es correcto');
    }
  });

  final validarDate = StreamTransformer<DateTime, DateTime>.fromHandlers(
      handleData: (date, sink) {
    if (date != null) {
      sink.add(date);
    } else {
      sink.addError('date no es correcto');
    }
  });
  /*
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no es correcto');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Más de 6 caracteres por favor');
    }
  });*/
}
