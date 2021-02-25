import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/application/auth/auth_bloc.dart';
import 'package:health_app/presentation/routes/router.gr.dart';

import '../../injection.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        child: MaterialApp(
          title: 'Notes',
          home: Container(),
          builder: ExtendedNavigator.builder(
            router: MyRouter(),
            builder: (context, extendedNav) => Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.green[800],
                accentColor: Colors.blueAccent,
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              child: extendedNav,
            ),
          ),
        ));
  }
}
