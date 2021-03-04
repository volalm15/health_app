import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_app/domain/auth/i_auth_facade.dart';
import 'package:health_app/infrastructure/auth/firebase_auth_facade.dart';

import 'application/auth/auth_notifier.dart';
import 'application/sign_in_form_notifier.dart';

final signInAuthFacadeProvider = Provider<IAuthFacade>(
  (ref) => FirebaseAuthFacade(FirebaseAuth.instance, GoogleSignIn()),
);

final signInFormNotifierProvider = StateNotifierProvider(
  (ref) => SignInNotifier(ref.watch(signInAuthFacadeProvider)),
);

final authNotifierProvider = StateNotifierProvider(
  (ref) => AuthNotifier(ref.watch(signInAuthFacadeProvider)),
);
