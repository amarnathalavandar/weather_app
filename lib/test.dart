import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:oauth2_client/web_oauth2_client.dart';

class MyWebOAuth2Client extends WebOAuth2Client {
  MyWebOAuth2Client({
    required String authorizeUrl,
    required String tokenUrl,
    required String redirectUri,
  }) : super(
          authorizeUrl: authorizeUrl,
          tokenUrl: tokenUrl,
          redirectUri: redirectUri,
        );

  @override
  Future<String?> authorize({
    required String clientId,
    String? clientSecret,
    required String scope,
    required String state,
    Map<String, dynamic>? customParams,
    bool enablePKCE = false,
    bool preferEphemeralSession = false,
  }) async {
    // Build the full redirect URL
    final authUrl = constructAuthorizeUrl(
      clientId: clientId,
      scope: scope,
      state: state,
      enablePKCE: enablePKCE,
      customParams: customParams,
    );

    // Redirect the current window (no popup)
    window.location.href = authUrl;
    return null; // You won't get a response here; handle it in redirect page
  }
}