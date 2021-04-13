

import 'package:cloud_firestore/cloud_firestore.dart';

class TokenPurchases {
  String? photoUrl;
  String? name;
  String? email;
  double? numberOfFollowers;
  bool? isStreamer;
  bool? isStreamerValidated;
  String? twitchChannel;
  String? tokenName;
  double? tokenPrice;
  double? donationAmount;
  double? tokenCount;
  double? numberOfTokenIssued;
  String? paypalLink;
  Timestamp? date;


  TokenPurchases(this.email,
      {this.name,
      this.numberOfFollowers,
      this.isStreamer,
      this.twitchChannel});

  TokenPurchases.map(Map<String, dynamic> map) {

    this.photoUrl = map["photo_url"] ?? "";
    this.email = map["email"];
    this.numberOfFollowers = _convertToDoubleValue(map["no_of_followers"]);
    this.twitchChannel = map["twitch_channel"];
    this.isStreamer = map["is_streamer"] ?? false;
    this.isStreamerValidated = map["is_streamer_validated"] ?? false;
    this.tokenName = map["token_name"];
    this.name = map["name"];
    this.tokenPrice = _convertToDoubleValue(map["token_price"]);
    this.numberOfTokenIssued =
        _convertToDoubleValue(map["number_of_token_issued"]);
    this.paypalLink = map["paypal_link"];
    this.date = map["date"] ?? null;
    this.tokenCount =  _convertToDoubleValue(map["token_count"]);
    this.donationAmount = _convertToDoubleValue(map["donation_amount"]);

  }

  @override
  String toString() {
    return "email : $email, numberOfFollowers: $numberOfFollowers, isStreamerValidated : $isStreamerValidated";
  }

  double? _convertToDoubleValue(dynamic value) {
    try {
      if (value == null) {
        return 0;
      }

      if (value.runtimeType == int) {
        return value.toDouble();
      }

      if (value.runtimeType == double) {
        return value;
      }

      if (value.runtimeType == String) {
        try {
          return double.parse(value);
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }

    return 0;
  }
}
