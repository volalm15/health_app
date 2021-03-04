import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:health_app/providers.dart';

class SignInForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(signInFormNotifierProvider.state);
    watch(signInFormNotifierProvider).addListener((state) {
      state.authFailureOrSuccessOption.fold(
        () {},
        (either) {
          either.fold(
            (failure) {
              showFlash(
                context: context,
                // A dialog cannot be persistent - must be poppable.
                builder: (context, controller) {
                  return Flash.dialog(
                    controller: controller,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    margin: const EdgeInsets.all(8),
                    // Again, FlashBar is a perfect candidate for the child widget.
                    child: FlashBar(
                      message: Text('This FlashBar looks like an AlertDialog.'),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            controller.dismiss();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            (_) {
              //ExtendedNavigator.of(context).replace(Routes.homePage);
              //context.read(authNotifierProvider).authCheckRequested();
            },
          );
        },
      );
    });
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: [
          const Text(
            '📝',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 130),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: 'Email',
            ),
            autocorrect: false,
            onChanged: (value) =>
                context.read(signInFormNotifierProvider).emailChanged(value),
            validator: (_) => state.emailAddress.value.fold(
              (f) => f.maybeMap(
                invalidEmail: (_) => 'Invalid Email',
                orElse: () => null,
              ),
              (_) => null,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: 'Password',
            ),
            autocorrect: false,
            obscureText: true,
            onChanged: (value) =>
                context.read(signInFormNotifierProvider).passwordChanged(value),
            validator: (_) => state.password.value.fold(
              (f) => f.maybeMap(
                shortPassword: (_) => 'Short Password',
                orElse: () => null,
              ),
              (_) => null,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => context
                      .read(signInFormNotifierProvider)
                      .signInWithEmailAndPasswordPressed(),
                  child: const Text('SIGN IN'),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => context
                      .read(signInFormNotifierProvider)
                      .registerWithEmailAndPasswordPressed(),
                  child: const Text('REGISTER'),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => context
                .read(signInFormNotifierProvider)
                .signInWithGooglePressed(),
            child: const Text(
              'SIGN IN WITH GOOGLE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
