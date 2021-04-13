import 'dart:core';
import 'package:flutter/material.dart';
import 'package:hypeeo_app/constants.dart';
import 'package:hypeeo_app/services/paypal_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum PaymentStatus { SUCCESS, FAIL }

class PaypalPayment extends StatefulWidget {
  final void Function(PaymentStatus) onFinish;

  double price;
  String clientId;
  String clientSecret;
  String streamerPaypal;

  PaypalPayment(
      {required this.price,
      required this.onFinish,
      required this.clientId,
      required this.clientSecret,
      required this.streamerPaypal
      });

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? checkoutUrl;

  String? executeUrl;

  String? accessToken;

  PaypalServices? services;

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'http://return.hypeeo.com';
  String cancelURL = 'http://cancel.hypeeo.com';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {

        services = PaypalServices(widget.clientId, widget.clientSecret);

        accessToken = await services!.getAccessToken();

        final transactions = getOrderParams();

        final res =
            await services!.createPaypalPayment(transactions, accessToken);

        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }

      } catch (e) {
        print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        showErrorSnackBar(context, "An error occured. Please try again.");
      }
    });


    showProgress();
    Future.delayed(Duration(seconds: 3), () {
      hideProgress();
    });
  }

  Map<String, dynamic> getOrderParams() {
    Map<String, dynamic> temp = {
      "intent": 'CAPTURE',
      "payer": {"payment_method": "paypal"},
      "purchase_units": [
        {
          "amount": {
            "currency_code": "USD",
            "value": widget.price.toString(),
          },
          "payee": {"email_address": widget.streamerPaypal}
        }
      ],
      "application_context": {"return_url": returnURL, "cancel_url": cancelURL}
    };

    return temp;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {

            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services!
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish(PaymentStatus.SUCCESS);
                  Navigator.of(context).pop();
                });
              } else {
                Navigator.of(context).pop();
              }
              //Navigator.of(context).pop();
            }
            if (request.url.contains(cancelURL)) {
              widget.onFinish(PaymentStatus.FAIL);
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}
