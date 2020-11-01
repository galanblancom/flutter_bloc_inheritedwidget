import 'package:flutter/material.dart';
import 'package:flutter_example/bloc/provider.dart';
import 'package:flutter_example/bloc/transaction_bloc.dart';
import 'package:flutter_example/models/transaction.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatelessWidget {
  void _submitData(TransactionBloc bloc, BuildContext context) {
    if (bloc.amount.isEmpty) {
      return;
    }
    final enteredTitle = bloc.title;
    final enteredAmount = double.parse(bloc.amount);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || bloc.date == null) {
      return;
    }

    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: enteredTitle,
        amount: enteredAmount,
        date: bloc.date);

    bloc.addTransaction(newTransaction);

    Navigator.of(context).pop();

    //bloc.changeTitle('');
    //bloc.changeAmount('');
    bloc.changeDate(null);
  }

  void _presentDatePicker(TransactionBloc bloc, BuildContext ctx) {
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      bloc.changeDate(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    TransactionBloc bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StreamBuilder(
                  stream: bloc.titleStream,
                  builder: (context, snapshot) {
                    return TextField(
                      decoration: InputDecoration(
                          labelText: 'Título', errorText: snapshot.error),
                      onChanged: bloc.changeTitle,
                      onSubmitted: (_) => _submitData(bloc, context),
                    );
                  }),
              StreamBuilder(
                  stream: bloc.amountStream,
                  builder: (context, snapshot) {
                    return TextField(
                      decoration: InputDecoration(
                          labelText: 'Monto', errorText: snapshot.error),
                      onChanged: bloc.changeAmount,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => _submitData(bloc, context),
                    );
                  }),
              StreamBuilder(
                  stream: bloc.dateStream,
                  builder: (context, snapshot) {
                    return Container(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(bloc.date == null
                                ? 'No ha seleccionado una fecha!'
                                : 'Picked date: ' +
                                    DateFormat('dd/MM/yyyy').format(bloc.date)),
                          ),
                          FlatButton(
                            onPressed: () => _presentDatePicker(bloc, context),
                            child: Text(
                              'Seleccionar fecha',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            textColor: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    );
                  }),
              StreamBuilder<Object>(
                  stream: bloc.formValidStream,
                  builder: (context, snapshot) {
                    return RaisedButton(
                        child: Text('Agregar gasto'),
                        textColor: Theme.of(context).textTheme.button.color,
                        color: Theme.of(context).primaryColor,
                        onPressed: snapshot.hasData
                            ? () => _submitData(bloc, context)
                            : null);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
