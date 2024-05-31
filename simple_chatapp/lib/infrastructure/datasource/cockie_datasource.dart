import 'dart:io';

import 'package:start/domain/entities/auth_information.dart';
import 'package:start/infrastructure/repositories/authentification_repository_impl.dart';
import 'package:start/util/config.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class CockieService {
  final _cookieManager = WebviewCookieManager();
  final String _authCookieName = 'auth';

  Future<bool> createAuthCoockie(
      String authKey, AuthenticationResult authCookie) async {
    return await createOrUpdateCoockie(_authCookieName, authCookie.toString());
  }

  Future<AuthInformation?> loadAuthInformation(String authKey) async {
    bool hasAuthCookie = await hasCookieByName(authKey);
    if (hasAuthCookie) {
      Cookie? cookie = await retrieveCookieByName(authKey);
      return AuthInformation()..verificationId = cookie!.value;
    } else {
      return null;
    }
  }

  Future<bool> createOrUpdateCoockie(String name, String value) async {
    bool isCreated = false;
    try {
      await _cookieManager.setCookies([
        Cookie(name, value)
          ..domain = Config.appHostname
          ..httpOnly = false
      ]);
      isCreated = true;
    } on Exception {
      isCreated = false;
    }
    return isCreated;
  }

  Future<bool> hasCookieByName(String name) async {
    List<Cookie> gotCookies =
        await _cookieManager.getCookies(Config.appHostname);

    Cookie? authCookie =
        gotCookies.where((cookie) => cookie.name == name).firstOrNull;
    return authCookie != null;
  }

  Future<Cookie?> retrieveCookieByName(String name) async {
    List<Cookie> gotCookies =
        await _cookieManager.getCookies(Config.appHostname);
    return gotCookies.where((cookie) => cookie.name == name).firstOrNull;
  }
}
