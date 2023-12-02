import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iba_resources_app/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider(
  (ref) => AuthController(
    authRepository: ref.read(authRepoProvider),
  ),
);

class AuthController {
  final AuthRepository _authRepository;

  // used initializer list to initialize private _authRepository variable
  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  void signUpWithMailAndPass(String name, String email, String password) {
    _authRepository.signUp(name, email, password);
  }

  void signInWithGoogle() {
    _authRepository.signInWithGoogle();
  }

  void signInWithFacebook() {
    _authRepository.signInWithFacebook();
  }
}
