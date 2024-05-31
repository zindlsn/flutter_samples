import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:start/domain/entities/auth_information.dart';
import 'package:start/infrastructure/repositories/authentification_repository_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthLocalStorageRepository auth = CookieLocalStorage();
  AuthBloc() : super(AuthInitial()) {
    on<AuthInitEvent>((event, emit) async {
      try {
        AuthInformation? authInformation = await auth.loadAuthInformation();
        if (authInformation != null) {
          emit(Authenticated());
        } else {
          emit(Unauthenticated());
        }
      } catch (ex) {
        emit(Unauthenticated());
      }
    });
  }
}
