// lib/services/okta_auth_service.dart

import 'package:openid_client/openid_client.dart';

class OktaAuthService {
  // === CONFIG ===
  final String issuerUrl = 'https://your-okta-domain.okta.com/oauth2/default';
  final String clientId = 'your-client-id';
  final Uri redirectUri = Uri.parse('http://localhost:4000/callback');

  Credential? _credential;

  // === LOGIN ===
  Future<UserInfo?> login() async {
    final issuer = await Issuer.discover(Uri.parse(issuerUrl));
    final client = Client(issuer, clientId);

    final authenticator = Authenticator(
      client,
      scopes: ['openid', 'profile', 'email'],
      port: redirectUri.port,
      redirectUri: redirectUri,
      urlLancher: (url) async {
        // This forces navigation to occur in the same window
        // Works for Flutter Web - launches in same tab
        window.location.href = url.toString();
      },
    );

    // Wait for the redirect with code → PKCE exchange handled by openid_client
    _credential = await authenticator.authorize();

    closeInAppWebView(); // Ensures cleanup after redirect

    final userInfo = await _credential!.getUserInfo();
    return userInfo;
  }

  // === Accessors ===
  String? get accessToken => _credential?.accessToken;
  String? get idToken => _credential?.idToken;
  bool get isLoggedIn => _credential != null;

  // === LOGOUT (Optional) ===
  Future<void> logout() async {
    if (_credential != null) {
      await _credential!.revokeToken();
      _credential = null;
    }
  }
}
