import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/bloc/provider.dart';
import 'pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Gastos Personales',
        home: HomePage(),
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.amber,
            errorColor: Colors.red,
            fontFamily: 'Quicksand',
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    button: TextStyle(color: Colors.white)))),
      ),
    );
  }
}
