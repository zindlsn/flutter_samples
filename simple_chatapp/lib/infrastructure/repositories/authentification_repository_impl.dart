import 'package:firebase_auth/firebase_auth.dart';
import 'package:localstorage/localstorage.dart';
import 'package:start/domain/entities/auth_information.dart';
import 'package:start/domain/entities/user_entity.dart';
import 'package:start/infrastructure/datasource/cockie_datasource.dart';

abstract class AuthService {
  AuthenticationResult? verifyPhoneNumber(String phonenumber);
  Future<UserEntity?> confirmPhoneNumber(
      AuthenticationResult result, String code);
  Future<AuthenticationResult?> verifyPhoneNumber2(String phonenumber);
}

class FirebaseAuthService extends AuthService {
  @override
  Future<AuthenticationResult?> verifyPhoneNumber2(String phonenumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    ConfirmationResult result =
        await auth.signInWithPhoneNumber("+491749346959");

    return FirebaseAuthResult()
      ..verificationId = result.verificationId
      ..phoneNumber = "+491749346959";
  }

  @override
  AuthenticationResult? verifyPhoneNumber(String phonenumber) {}

  @override
  Future<UserEntity?> confirmPhoneNumber(
      AuthenticationResult result, String code) async {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: result.verificationId!,
      smsCode: code,
    );
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        UserEntity user = UserEntity(
            userId: userCredential.user!.uid,
            name: userCredential.user!.displayName);
        return Future.value(user);
      }
      throw FirebaseAuthException(code: code);
    } catch (ex) {
      rethrow;
    }
  }
}

abstract class AuthenticationResult {
  String? verificationId;
  String? phoneNumber;
}

class FirebaseAuthResult extends AuthenticationResult {}

class AuthentificationRepositoryImpl {
  FirebaseAuth auth = FirebaseAuth.instance;
  ConfirmationResult? confirm;
  AuthInformation? authCookie;

  CockieService cockieDataSource = CockieService();

  void login(String code) async {
    UserCredential? user = await confirmPhoneNumber(code);
    if (user != null) {
      //   cockieDataSource
      //    .createAuthCoockie(AuthInformation()..uid = user.user.uid);
    }
  }

  Future<UserCredential?> confirmPhoneNumber(String code) async {
    try {
      return await confirm!.confirm(code);
    } catch (ex) {
      print(ex);
    }

    return null;
  }

  Future<UserCredential?> verifyByPhone(String phoneNumber) async {
    try {
      UserCredential? credentials;
      ConfirmationResult result =
          await auth.signInWithPhoneNumber("+491749346959");
      result.confirm("1521");
      /* await auth.verifyPhoneNumber(
          phoneNumber: "004915784268848",
          verificationCompleted: (x) async {
            credentials = await auth.signInWithCredential(x);
          },
          verificationFailed: (x) {
            print(x);
          },
          codeSent: (x, y) {},
          codeAutoRetrievalTimeout: (x) {});
      if (credentials?.user != null) {
        print(credentials!.user!.uid);
      } */
    } catch (ex) {
      print(ex);
    }
    return null;
  }
}

abstract class PharmacyInfoLocalStorage {
  String pharmacyKey = "pid";
  Future<bool> savePharmacyId(String id);
  Future<bool> savePageIndex(String index);
}

class PharmacyInfoLocalStorageImpl extends PharmacyInfoLocalStorage {
  CockieService cockieService = CockieService();
  @override
  Future<bool> savePageIndex(String index) async {
    return await cockieService.createOrUpdateCoockie(pharmacyKey, index);
  }

  @override
  Future<bool> savePharmacyId(String id) {
    throw UnimplementedError();
  }
}

class AuthServiceOld {
  AuthLocalStorageRepository localStorage = CookieLocalStorage();

  Future<bool> saveAuth(AuthenticationResult auth) async {
    return await localStorage.saveAuth(auth);
  }
}

class PharmacyServiceImpl {
  PharmacyInfoLocalStorage storage = PharmacyInfoLocalStorageImpl();

  savePid(String id) {
    storage.savePharmacyId(id);
  }
}

abstract class AuthLocalStorageRepository {
  final String authKey = 'auth';
  final String idKey = 'id';
  Future<bool> saveAuth(AuthenticationResult auth);
  Future<AuthInformation?> loadAuthInformation();
}

class CookieLocalStorage extends AuthLocalStorageRepository {
  CockieService cockieService = CockieService();

  @override
  Future<AuthInformation?> loadAuthInformation() async {
    return await cockieService.loadAuthInformation(authKey);
  }

  @override
  Future<bool> saveAuth(AuthenticationResult auth) async {
    return await cockieService.createOrUpdateCoockie(
        idKey, auth.verificationId!);
  }
}

class TestLocalStorage extends AuthLocalStorageRepository {
  @override
  Future<AuthInformation?> loadAuthInformation() {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveAuth(AuthenticationResult auth) {
    throw UnimplementedError();
  }
}

class DeviceLocalStorage extends AuthLocalStorageRepository {
  void init() async {
    await initLocalStorage();
  }

  @override
  Future<AuthInformation?> loadAuthInformation() {
    return Future.value(null);
  }

  @override
  Future<bool> saveAuth(AuthenticationResult authData) {
    try {
      // localStorage.setItem(authData, authData.toCookie());
      return Future.value(true);
    } catch (x) {
      return Future.value(false);
    }
  }
}
