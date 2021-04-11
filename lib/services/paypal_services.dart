import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

class PaypalServices {

  final String clientId;
  final String secret;

  PaypalServices(this.clientId, this.secret);

    // String clientId =
    //     'AfGo36HVDv8UOd05jCfpO-Alx4JK_sn7WzywgrPzmZS00RkYD8axPomT8_8zTlh3c-WD_F5j6CLbBLuc';
    // String secret =
    //     'EALb_NCACjX7HUwIhJ-Q8870Gdcuk-z3j4W0B_iHuA3SJe0B2c3ObKCmLqBMowTjKU4ZjzgKfhUEbRLK';


  // String domain = "https://api-m.sandbox.paypal.com"; // for sandbox mode

  String domain = "https://api-m.paypal.com"; // for production mode

  Future<String?> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post('$domain/v1/oauth2/token?grant_type=client_credentials');
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>?> createPaypalPayment(
      transactions, accessToken) async {
    try {
      // var response = await http.post("$domain/v1/payments/payment",
      var response = await http.post("$domain/v2/checkout/orders/",
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);

      if (response.statusCode == 201) {

        if (body["links"] != null && body["links"].length > 0) {

          List links = body["links"];


          String executeUrl = "";
          String approvalUrl = "";

          final item = links.firstWhere((o) => o["rel"] == "approve",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "capture",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String?> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }


}