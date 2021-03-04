import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_app/domain/auth/i_auth_facade.dart';

part 'auth_notifier.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.authenticated() = Authenticated;
  const factory AuthState.unauthenticated() = Unauthenticated;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final IAuthFacade _authFacade;

  Future<void> authCheckRequested() async {
    final userOption = _authFacade.getSignedInUser();
    userOption.fold(
      () {
        state = const AuthState.unauthenticated();
      },
      (_) {
        state = const AuthState.authenticated();
      },
    );
  }

  Future<void> signOut(final String email) async {
    await _authFacade.signOut();
    const AuthState.unauthenticated();
  }

  AuthNotifier(this._authFacade) : super(const AuthState.initial());
}
