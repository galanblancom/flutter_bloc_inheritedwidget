import 'package:flutter/material.dart';
import 'package:flutter_example/bloc/provider.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of(context);

    return StreamBuilder(
        stream: bloc.userTransactionsStream,
        builder: (context, snapshot) {
          return Container(
            child: (bloc.allTransactions == null ||
                    bloc.allTransactions.isEmpty)
                ? Column(
                    children: <Widget>[
                      Text(
                        'No hay gastos resgistrados!',
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 200,
                          child: Image.asset(
                            'assets/images/waiting.png',
                            fit: BoxFit.cover,
                          )),
                    ],
                  )
                : ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Card(
                        elevation: 8,
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(
                                      '\$${bloc.allTransactions[index].amount.toStringAsFixed(2)}'),
                                ),
                              ),
                            ),
                            title: Text(
                              bloc.allTransactions[index].title,
                              style: Theme.of(context).textTheme.title,
                            ),
                            subtitle: Text(
                              DateFormat.yMMMd()
                                  .format(bloc.allTransactions[index].date),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
                                color: Theme.of(context).errorColor,
                                onPressed: () {
                                  bloc.deleteTransaction(
                                      bloc.allTransactions[index].id);
                                })),
                      );
                    },
                    itemCount: bloc.allTransactions.length,
                  ),
          );
        });
  }
}
