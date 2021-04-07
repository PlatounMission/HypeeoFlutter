

class AppUser {
  late String? name;
  late String? email;
  late double? numberOfFollowers;
  late bool? isStreamer;
  late bool? isStreamerValidated;
  late String? twitchChannel;
  late String? tokenName;
  late double? tokenPrice;
  late double? numberOfTokenIssued;
  late String? paypalLink;
  late bool? isAnynymous;
  bool? isAdmin;

  AppUser(this.email,
      {this.name, this.numberOfFollowers, this.isStreamer, this.twitchChannel, this.isAdmin});

  AppUser.map(Map<String, dynamic> map) {

    print(map.toString());
    print("_______________________");
    this.email = map["email"];
    this.numberOfFollowers = _convertToDoubleValue(map["no_of_followers"]);
    this.twitchChannel = map["twitch_channel"];
    this.isStreamer = map["is_streamer"] ?? false;
    this.isStreamerValidated = map["is_streamer_validated"] ?? false;
    this.tokenName = map["token_name"];
    this.tokenPrice = _convertToDoubleValue(map["token_price"]);
    this.numberOfTokenIssued = _convertToDoubleValue(map["number_of_token_issued"]);
    this.paypalLink = map["paypal_link"];
    this.isAnynymous = (map["email"] == null);

    print("new user has been added");
    print(this.toString());
    print("_______________________");
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
        } catch(e) {
          print(e);
        }
      }


    } catch(e) {
      print(e);
    }

    return 0;
  }

}
