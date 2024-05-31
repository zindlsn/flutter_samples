import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/domain/entities/auth_information.dart';
import 'package:start/domain/entities/user_entity.dart';
import 'package:start/infrastructure/datasource/cockie_datasource.dart';
import 'package:start/infrastructure/repositories/authentification_repository_impl.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  var auth = FirebaseAuthService();
  var cookieDatasource = CockieService();
  LoginBloc() : super(LoginInitial()) {
    on<AuthCheckRequestedEvent>((event, emit) async {
      AuthLocalStorageRepository localStorageRepository = CookieLocalStorage();
      AuthInformation? auth =
          await localStorageRepository.loadAuthInformation();
      if (auth != null) {
        LoginSuccess();
      }
    });
    on<PhoneLogin>((event, emit) async {
      AuthenticationResult? result = await auth.verifyPhoneNumber2("");
      emit(PhoneVerified(result: result!));
    });
    on<ConfirmPhoneNumber>((event, emit) async {
      UserEntity? user =
          await auth.confirmPhoneNumber(event.authResult, event.code);

      AuthLocalStorageRepository localStorageRepository = CookieLocalStorage();
      localStorageRepository.saveAuth(event.authResult);
      if (user != null) {
        emit(LoginSuccess());
      }
    });
  }
}
