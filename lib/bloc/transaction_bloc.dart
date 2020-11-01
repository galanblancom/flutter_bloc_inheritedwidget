import 'dart:async';
import 'package:flutter_example/models/transaction.dart';

import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class TransactionBloc with Validators {
  final _titleController = BehaviorSubject<String>();
  final _amountController = BehaviorSubject<String>();
  final _dateController = BehaviorSubject<DateTime>();
  final _userTransactionsController =
      BehaviorSubject<List<Transaction>>.seeded([]);

  // Recuperar los datos del Stream
  Stream<String> get titleStream =>
      _titleController.stream.transform(validarTitle);
  Stream<String> get amountStream =>
      _amountController.stream.transform(validarAmount);
  Stream<DateTime> get dateStream =>
      _dateController.stream.transform(validarDate);
  Stream<List<Transaction>> get userTransactionsStream =>
      _userTransactionsController.stream;

  Stream<bool> get formValidStream => Rx.combineLatest3(
      titleStream, amountStream, dateStream, (t, a, d) => true);

  // Insertar valores al Stream
  Function(String) get changeTitle => _titleController.sink.add;
  Function(String) get changeAmount => _amountController.sink.add;
  Function(DateTime) get changeDate => _dateController.sink.add;
  Function(Transaction) get addTransaction => (Transaction t) {
        var l = _userTransactionsController.value;
        if (l == null) {
          l = [];
        }
        l.add(t);
        _userTransactionsController.sink.add(l);
      };

  Function(String) get deleteTransaction => (String id) {
        final l = _userTransactionsController.value;
        l.removeWhere((transaction) {
          return transaction.id == id;
        });
        return _userTransactionsController.sink.add(l);
      };

  // Obtener el último valor ingresado a los streams
  String get title => _titleController.value;
  String get amount => _amountController.value;
  DateTime get date => _dateController.value;

  List<Transaction> get allTransactions => _userTransactionsController.value;
  List<Transaction> get recentTransactions =>
      _userTransactionsController.value == null
          ? []
          : _userTransactionsController.value.where((transaction) {
              return transaction.date
                  .isAfter(DateTime.now().subtract(Duration(days: 7)));
            }).toList();

  dispose() {
    _titleController?.close();
    _amountController?.close();
    _dateController?.close();
    _userTransactionsController?.close();
  }
}
