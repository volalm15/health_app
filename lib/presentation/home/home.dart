import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/application/auth/auth_bloc.dart';
import 'package:health_app/presentation/routes/router.gr.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeMap(
          unauthenticated: (_) =>
              ExtendedNavigator.of(context).replace(Routes.signInPage),
          orElse: () {},
        );
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Text("Hellooooo :D"),
            ElevatedButton(
              onPressed: () =>
                  context.read<AuthBloc>().add(const AuthEvent.signOut()),
              child: const Text("Log out"),
            )
          ],
        ),
      ),
    );
  }
}
