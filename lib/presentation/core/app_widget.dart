import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_app/presentation/routes/router.gr.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      home: Container(),
      builder: ExtendedNavigator.builder(
        router: MyRouter(),
        builder: (context, extendedNav) => Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.pink[800],
            accentColor: Colors.red,
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          child: extendedNav,
        ),
      ),
    );
  }
}
