import 'package:flutter/material.dart';
import 'package:flutter_example/bloc/provider.dart';
import 'package:flutter_example/widgets/chart.dart';
import 'package:flutter_example/widgets/new_transaction.dart';
import 'package:flutter_example/widgets/transaction_list.dart';

class HomePage extends StatelessWidget {
  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            child: GestureDetector(
              onTap: () {},
              child: NewTransaction(),
              behavior: HitTestBehavior.opaque,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    final appBar = AppBar(
      title: Text(
        'Gastos Personales',
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context))
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: StreamBuilder(
                    stream: bloc.userTransactionsStream,
                    builder: (context, snapshot) {
                      return Chart(bloc.recentTransactions);
                    })),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionList())
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
