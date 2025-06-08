import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class PayPalApi {
  final String baseUrl = "http://10.0.2.2:7125/";

  String certificate = '''
-----BEGIN CERTIFICATE-----
MIIDsTCCApmgAwIBAgIUaWYGAk2nrsE0FQDhGbq0Z4Gy6xYwDQYJKoZIhvcNAQEL
BQAwaDELMAkGA1UEBhMCQkExEDAOBgNVBAgMB0hhZHppY2kxEDAOBgNVBAcMB0hh
ZHppY2kxDjAMBgNVBAMMBUxlamxhMSUwIwYJKoZIhvcNAQkBFhZtYXJpYy5sZWps
YUBlZHUuZml0LmJhMB4XDTIzMTAyNjIwMTEzMloXDTI0MTAyNTIwMTEzMlowaDEL
MAkGA1UEBhMCQkExEDAOBgNVBAgMB0hhZHppY2kxEDAOBgNVBAcMB0hhZHppY2kx
DjAMBgNVBAMMBUxlamxhMSUwIwYJKoZIhvcNAQkBFhZtYXJpYy5sZWpsYUBlZHUu
Zml0LmJhMB4XDTIzMTAyNjIwMTEzMloXDTI0MTAyNTIwMTEzMlowaDELMAkGA1UE
BhMCQkExEDAOBgNVBAgMB0hhZHppY2kxEDAOBgNVBAcMB0hhZHppY2kxDjAMBgNV
BAMMBUxlamxhMSUwIwYJKoZIhvcNAQkBFhZtYXJpYy5sZWpsYUBlZHUuZml0LmJh
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAn13UQByHQJTT3cHwOzBa
YAHPHAcG9kU7zb9SWDlIYqbjT5OxvavQHR/AyijLDUXxzlUBTwFYTmfPQmlRVfU5
z1+tukTKqczMF3FqCAZBpurfyeCFb3iHIzFMgrh+8LJk+WNalNxUxD6iBHSsCkBb
nsvCYIquFOJ+sofTjz6qkuMKHHbkmR2R1Mz824Rd4cm5UMhf0MjEFN48bW0a+xAp
ds7ol1ILHlhKB5eks0U+wI425NaJcoFyHULb5RE6kNKlGwqNH2a8BYHNsl75p009
c6nJiafkwfxF0UVmQidQ6tDsrW370Rg4mSVxDI6qvzgxjSzvBF/HEDO3Mz9Di5oX
0wIDAQABo1MwUTAdBgNVHQ4EFgQUkfxAEO68rI1Leeh7mkq2PXZ4wTYwHwYDVR0j
BBgwFoAUkfxAEO68rI1Leeh7mkq2PXZ4wTYwDwYDVR0TAQH/BAUwAwEB/zANBgkq
hkiG9w0BAQsFAAOCAQEAVzc/RBbkZZRgluK5yui6/2HNApvF4h0Wky7NOG6Diq5k
n7ceogfngtH+OJ8SxGWATe78t31hrlCvSIwIyy+EtFn7qCqwu2fjUhu4pt8dkhqE
1YmYvS9/0pLYb1AhjZ2TJGEovR++CE4CiPn5g0qHqXSZHKpjRNh9h0iv0YccKtCf
or/3veAHCGW82gqkFm549L3j+JOVIJz8ygkWD0JXHP8/Duq+wzriJZmnfw/YyqcC
ZVh7K/Kh24ci0T0Z3byTSXGcwn8plvyqx87RybGeOpSG17dv33PAF5P+jSRE4wJ+
H3kNyVkuwAfFoNxQLHu3RInQnWPOBhmgi8AjyzTMhg==
-----END CERTIFICATE-----
''';

  String privateKey = '''
-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCfXdRAHIdAlNPd
wfA7MFpgAc8cBwb2RTvNv1JYOUhipuNPk7G9q9AdH8DKKMsNRfHOVQFPAVhOZ89C
aVFV9TnPX626RMqpzMwXcWoIBkGm6t/J4IVveIcjMUyCuH7wsmT5Y1qU3FTEPqIE
dKwKQFuey8Jgiq4U4n6yh9OPPqqS4wocduSZHZHUzPzbhF3hyblQyF/QyMQU3jxt
bRr7ECl2zuiXUgseWEoHl6SzRT7Ajjbk1olygXIdQtvlETqQ0qUbCo0fZrwFgc2y
XvmnTT1zqcmJp+TB/EXRRWZCJ1Dq0OytbfvRGDiZJXEMjqq/ODGNLO8EX8cQM7cz
P0OLmhfTAgMBAAECggEACT0/2m2s+7YFKHSfcFcHzkwcjUPtB+cQpgeDByFfDHUf
dZQa+GOXH7EhFLdTulPFRpCQEFwEGhuTnQaNFB4w+VBTOprVYw3AAVXub0Opl7tD
OSl+ou1KbGRlyqhWl67IAttbO4kgkvYMn5SCCuAbT7QBc2Zm3EgbT09nmQTpj7Vp
iAd9Gu2I2nYt5cCHooIRpUwluuIPo4sFr64NdvnExGg7zhsCPszk7HOr/1Bh5JFX
e48VXCg/9bFm5nXd3B1EQafNYSUmFbRqbxrzztaKV5SN5sa7W111S62uWahmJ3nW
17TAGvizt8kqOezougSIf5C0eWdr6h0/JgfxwlTfxQKBgQDQ/9TKj9DRbdzRBcqj
R99IH2s4Lx6xZzgsF1+gOsOJLXhTEgJLsOx6Uy2nSiMGyvNA8fWiZkc2zdw16WVK
wRfoLH5IM8TkEoH5bADcIpLnkIlw8toUfif8AfnBS00qXMC4N0Jl0RtOJNvjw0j7
OF4rbtyejsauSt9NC9zS7zD1BwKBgQDDNJ5AjE43BSNJUSpkL/OHGXV55al/sBA8
JsV6JJMeveafVcF0/QbDllLZZgI78CHHf7FOUiheauZ08RNOPfM+GW37FBchxVnn
PXtDBy42WLTqCMwewMJa6hRcAWnhB64Dx0lHQTA+m/r9Ojzqln/WnFzpQ4KSP+lv
fdtlcQK/1QKBgG7Ng0oU7vdpUG18rY7dVtIM3jI+QP56o7w0dB0lqm76rVUVMiRg
2y6LFKQhWOqMBGUFIl4D7XNvtnTalToJnxwXIqgy0gq8iS3sBZSvu8SKy2MXTWkZ
7SbdAUVqH7H61K2Vll0WfGx0fCOHcBTIMJzEPLDPLyROS460YFFwQDtXAoGBALeY
WqstCzdWXrzLWQqHyw0q1cHDTqsopexdLujVU4XbZ/g+SMjGXkFAtkWAWuOS08J2
CAY44X0EICKmxtiVDZ0/f6BhYexCWG9T9QWy0DUPM4DWq1zVQTcO5/0s2y9p8LHf
Er2wwzZvsB3RU4/z4uKvh/dgpoL1F5HkFqCPLN3NAoGBAMqehd5WfX9bDB9gY8oB
ha9LntZFTT/HLLOdwse9On2hvlSGIz2fwKLmrA5OXo3JfD5wk31luOoxBBHoDWE9
xBYaER1enDbowf1xEyNLrf0PO3UwhkpvdHFmHF8OTTsK+Xa5eFDEYY+6rWjFIblK
0v4i1i1o1dG/hBCfIE/m6+UU
-----END PRIVATE KEY-----
''';

  Future<String> getAuthorizationUrl() async {
    var context = SecurityContext.defaultContext
      ..useCertificateChainBytes(
        utf8.encode(certificate),
      )
      ..usePrivateKeyBytes(
        utf8.encode(privateKey),
      );

    var client = HttpClient(context: context);
    client.badCertificateCallback = (
      X509Certificate cert,
      String host,
      int port,
    ) {
      // Handle certificate that can't be authenticated
      // Returning 'true' by itself is not really safe...
      return true;
    };

    var request =
        await client.getUrl(Uri.parse('$baseUrl/api/paypal/authorization-url'));
    var response = await request.close();

    // U ovom trenutku, možeš obraditi response, npr. čitati ga kao string.
    var responseBody = await utf8.decodeStream(response);

    return responseBody;
  }

  /* Future<String> getAuthorizationUrl() async {
    try {
      var securityContext = SecurityContext(withTrustedRoots: true);
      securityContext.setTrustedCertificatesBytes(utf8.encode(
          'C:\\Users\\Lenovo-T440p\\Desktop\\sem2\\prodajaNekretnina2\\UI\\prodajanekretnina_mobile\\certificates\\cert.pem'));

      // Dodaj ovo
      securityContext.usePrivateKeyBytes(Uint8List.fromList(utf8.encode('''
-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCfXdRAHIdAlNPd
wfA7MFpgAc8cBwb2RTvNv1JYOUhipuNPk7G9q9AdH8DKKMsNRfHOVQFPAVhOZ89C
aVFV9TnPX626RMqpzMwXcWoIBkGm6t/J4IVveIcjMUyCuH7wsmT5Y1qU3FTEPqIE
dKwKQFuey8Jgiq4U4n6yh9OPPqqS4wocduSZHZHUzPzbhF3hyblQyF/QyMQU3jxt
bRr7ECl2zuiXUgseWEoHl6SzRT7Ajjbk1olygXIdQtvlETqQ0qUbCo0fZrwFgc2y
XvmnTT1zqcmJp+TB/EXRRWZCJ1Dq0OytbfvRGDiZJXEMjqq/ODGNLO8EX8cQM7cz
P0OLmhfTAgMBAAECggEACT0/2m2s+7YFKHSfcFcHzkwcjUPtB+cQpgeDByFfDHUf
dZQa+GOXH7EhFLdTulPFRpCQEFwEGhuTnQaNFB4w+VBTOprVYw3AAVXub0Opl7tD
OSl+ou1KbGRlyqhWl67IAttbO4kgkvYMn5SCCuAbT7QBc2Zm3EgbT09nmQTpj7Vp
iAd9Gu2I2nYt5cCHooIRpUwluuIPo4sFr64NdvnExGg7zhsCPszk7HOr/1Bh5JFX
e48VXCg/9bFm5nXd3B1EQafNYSUmFbRqbxrzztaKV5SN5sa7W111S62uWahmJ3nW
17TAGvizt8kqOezougSIf5C0eWdr6h0/JgfxwlTfxQKBgQDQ/9TKj9DRbdzRBcqj
R99IH2s4Lx6xZzgsF1+gOsOJLXhTEgJLsOx6Uy2nSiMGyvNA8fWiZkc2zdw16WVK
wRfoLH5IM8TkEoH5bADcIpLnkIlw8toUfif8AfnBS00qXMC4N0Jl0RtOJNvjw0j7
OF4rbtyejsauSt9NC9zS7zD1BwKBgQDDNJ5AjE43BSNJUSpkL/OHGXV55al/sBA8
JsV6JJMeveafVcF0/QbDllLZZgI78CHHf7FOUiheauZ08RNOPfM+GW37FBchxVnn
PXtDBy42WLTqCMwewMJa6hRcAWnhB64Dx0lHQTA+m/r9Ojzqln/WnFzpQ4KSP+lv
fdtlcQK/1QKBgG7Ng0oU7vdpUG18rY7dVtIM3jI+QP56o7w0dB0lqm76rVUVMiRg
2y6LFKQhWOqMBGUFIl4D7XNvtnTalToJnxwXIqgy0gq8iS3sBZSvu8SKy2MXTWkZ
7SbdAUVqH7H61K2Vll0WfGx0fCOHcBTIMJzEPLDPLyROS460YFFwQDtXAoGBALeY
WqstCzdWXrzLWQqHyw0q1cHDTqsopexdLujVU4XbZ/g+SMjGXkFAtkWAWuOS08J2
CAY44X0EICKmxtiVDZ0/f6BhYexCWG9T9QWy0DUPM4DWq1zVQTcO5/0s2y9p8LHf
Er2wwzZvsB3RU4/z4uKvh/dgpoL1F5HkFqCPLN3NAoGBAMqehd5WfX9bDB9gY8oB
ha9LntZFTT/HLLOdwse9On2hvlSGIz2fwKLmrA5OXo3JfD5wk31luOoxBBHoDWE9
xBYaER1enDbowf1xEyNLrf0PO3UwhkpvdHFmHF8OTTsK+Xa5eFDEYY+6rWjFIblK
0v4i1i1o1dG/hBCfIE/m6+UU
-----END PRIVATE KEY-----
''')));

      var httpClient = HttpClient(context: securityContext);

      var request = await httpClient
          .getUrl(Uri.parse('$baseUrl/api/paypal/authorization-url'));
      var response = await request.close();

      if (response.statusCode == 200) {
        var responseBody = await response.transform(utf8.decoder).join();
        return responseBody;
      } else {
        throw 'HTTP Error: ${response.statusCode}';
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }*/

  /* Future<String> getAuthorizationUrl() async {
    var httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

    final response =
        await http.get(Uri.parse('$baseUrl/api/paypal/authorization-url'));
    return response.body.toString();
  }*/

  Future<String> getAccessToken(String authorizationCode) async {
    final response = await http.post(
        Uri.parse('$baseUrl/api/paypal/access-token'),
        body: authorizationCode);
    return response.body;
  }

  Future<String> createPayment(double amount, String currency, String returnUrl,
      String cancelUrl) async {
    final paymentDetails = {
      'amount': amount,
      'currency': currency,
      'returnUrl': returnUrl,
      'cancelUrl': cancelUrl,
    };

    final response = await http.post(
        Uri.parse('$baseUrl/api/paypal/create-payment'),
        body: paymentDetails);
    return response.body;
  }
}
