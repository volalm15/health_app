import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_app/domain/auth/auth_failure.dart';
import 'package:health_app/domain/auth/i_auth_facade.dart';
import 'package:health_app/domain/auth/value_objects.dart';

part 'sign_in_form_notifier.freezed.dart';

@freezed
abstract class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    @required EmailAddress emailAddress,
    @required Password password,
    @required bool showErrorMessages,
    @required bool isSubmitting,
    @required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
  }) = _SignInFormState;

  factory SignInFormState.initial() => SignInFormState(
        emailAddress: EmailAddress(''),
        password: Password(''),
        showErrorMessages: false,
        isSubmitting: false,
        authFailureOrSuccessOption: none(),
      );
}

class SignInNotifier extends StateNotifier<SignInFormState> {
  final IAuthFacade _authFacade;

  SignInNotifier(this._authFacade) : super(SignInFormState.initial());

  void emailChanged(final String email) {
    state = state.copyWith(
      emailAddress: EmailAddress(email),
      authFailureOrSuccessOption: none(),
    );
  }

  void passwordChanged(final String passwordStr) {
    state = state.copyWith(
      password: Password(passwordStr),
      authFailureOrSuccessOption: none(),
    );
  }

  void registerWithEmailAndPasswordPressed() {
    _performActionOnAuthFacadeWithEmailAndPassword(
      _authFacade.registerWithEmailAndPassword,
    );
  }

  void signInWithEmailAndPasswordPressed() {
    _performActionOnAuthFacadeWithEmailAndPassword(
      _authFacade.signInWithEmailAndPassword,
    );
  }

  Future<void> signInWithGooglePressed() async {
    state = state.copyWith(
      isSubmitting: true,
      authFailureOrSuccessOption: none(),
    );
    final failureOrSuccess = await _authFacade.signInWithGoogle();
    state = state.copyWith(
      isSubmitting: false,
      authFailureOrSuccessOption: some(failureOrSuccess),
    );
  }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
    Future<Either<AuthFailure, Unit>> Function({
      @required EmailAddress emailAddress,
      @required Password password,
    })
        forwardedCall,
  ) async* {
    Either<AuthFailure, Unit> failureOrSuccess;

    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      state = state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      failureOrSuccess = await forwardedCall(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }

    state = state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOrSuccessOption: optionOf(failureOrSuccess),
    );
  }
}
