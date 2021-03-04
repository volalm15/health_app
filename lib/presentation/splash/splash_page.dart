import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_app/presentation/routes/router.gr.dart';
import 'package:health_app/providers.dart';

class SplashPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    context.read(authNotifierProvider).authCheckRequested();

    context.read(authNotifierProvider).addListener((state) {
      state.map(
          initial: (_) {
            print("initial");
          },
          authenticated: (_) {
            ExtendedNavigator.of(context).replace(Routes.homePage);
          },
          unauthenticated: (_) =>
              ExtendedNavigator.of(context).replace(Routes.signInPage));
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
