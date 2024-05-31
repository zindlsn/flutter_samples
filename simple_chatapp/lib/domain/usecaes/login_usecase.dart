import 'package:start/infrastructure/repositories/authentification_repository_impl.dart';

class LoginUsecase {
  AuthLocalStorageRepository authStorageRepository;
  AuthentificationRepositoryImpl authRepo = AuthentificationRepositoryImpl();

  LoginUsecase({required this.authStorageRepository});
}
