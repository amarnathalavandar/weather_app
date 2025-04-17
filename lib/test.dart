import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class OktaOAuthClient extends OAuth2Client {
  OktaOAuthClient()
      : super(
          authorizeUrl: 'https://{yourOktaDomain}/oauth2/default/v1/authorize',
          tokenUrl: 'https://{yourOktaDomain}/oauth2/default/v1/token',
          redirectUri: 'http://localhost:8000/',
          customUriScheme: 'http',
        );
}

class OktaAuthService {
  late OAuth2Helper oauth2Helper;

  OktaAuthService() {
    final client = OktaOAuthClient();
    oauth2Helper = OAuth2Helper(
      client,
      grantType: OAuth2Helper.AUTHORIZATION_CODE_PKCE,
      clientId: '{yourClientId}',
      scopes: ['openid', 'profile', 'email'],
    );
  }

  Future<void> login() async {
    final token = await oauth2Helper.getToken();
    if (token != null) {
      print('Access Token: ${token.accessToken}');
    } else {
      print('Login failed');
    }
  }

  Future<void> logout() async {
    // Implement logout logic if necessary
  }
}