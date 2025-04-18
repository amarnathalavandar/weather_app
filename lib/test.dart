import 'package:openid_client/openid_client.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

Future<void> loginWithOkta() async {
  // Your OKTA domain and client info
  const String issuerUrl = 'https://your-okta-domain.okta.com/oauth2/default';
  const String clientId = 'your-client-id';
  const String redirectUri = 'http://localhost:port/callback';

  final uri = Uri.parse(issuerUrl);
  final issuer = await Issuer.discover(uri);
  final client = Client(issuer, clientId);

  // Create an authenticator with PKCE
  final authenticator = Authenticator(
    client,
    scopes: ['openid', 'profile', 'email'],
    port: 4000, // Choose any free port
    redirectUri: Uri.parse(redirectUri),
  );

  try {
    final c = await authenticator.authorize();
    final token = await c.getTokenResponse();

    print("Access token: ${token.accessToken}");
    print("ID token: ${token.idToken}");

    // You can now use the token for authenticated requests
  } catch (e) {
    print("Error during authentication: $e");
  }
}
