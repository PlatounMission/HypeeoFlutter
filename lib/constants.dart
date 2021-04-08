import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:number_display/number_display.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart' show FlutterLocalNotificationsPlugin;

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();

const KADMIN_EMAIL = "admin@gmail.com";

// Colors
const kPrimaryColor = Color(0xFF15161B);
const kSecondryColor = Color(0xFFFFFFFF);
const kSecondaryLightColor = Color(0xFFE4E9F2);
const kSecondaryDarkColor = Color(0xFF023047);
const kAccentLightColor = Color(0xFFACEEF3);
const kAccentDarkColor = Color(0xFF023047);
const kBackgroundDarkColor = Color(0xFF3A3A3A);
const kSurfaceDarkColor = Color(0xFF222225);
// Icon Colors
const kAccentIconLightColor = Color(0xFFECEFF5);
const kAccentIconDarkColor = Color(0xFF303030);
const kPrimaryIconLightColor = Color(0xFFECEFF5);
const kPrimaryIconDarkColor = Color(0xFF232323);
// Text Colors
const kBodyTextColorLight = Color(0xFFFFFFFF);
const kBodyTextColorDark = Color(0xFF023047);
const kTitleTextLightColor = Color(0xFF101112);
const kTitleTextDarkColor = Colors.white;

const kShadowColor = Color(0xFF364564);

const kPrimaryLightColor = Color(0xFFEFC2A9);

const kButtonColor = Color(0xFF5E5CE6);
const kTwitchColor = Color(0xFFD921EF);

Future splashProgress() async {
  EasyLoading.instance.backgroundColor = kPrimaryColor;
  EasyLoading.instance.indicatorColor = kPrimaryColor;
  EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.dualRing;
  await EasyLoading.show(
      maskType: EasyLoadingMaskType.clear, dismissOnTap: false);
}

Future showProgress() async {
  EasyLoading.instance.maskColor = kButtonColor.withOpacity(0.1);
  EasyLoading.instance.progressColor = Colors.white;
  EasyLoading.instance.indicatorColor = kPrimaryColor;
  EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ring;
  await EasyLoading.show(
    maskType: EasyLoadingMaskType.custom,
    dismissOnTap: false,
  );
}

Future hideProgress() async {
  await EasyLoading.dismiss();
}

extension AppConstants on SharedPreferences {}

void showErrorAlert(BuildContext context, String title, String desc) {
  Alert(
    context: context,
    type: AlertType.error,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        color: kButtonColor,
        radius: BorderRadius.circular(29),
        child: Text(
          "Okay",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

void showSuccessSnackBar(BuildContext context, String title) {
  showFlash(
    context: context,
    duration: Duration(seconds: 2),
    builder: (context, controller) {
      return Flash(
        backgroundColor: Colors.green,
        position: FlashPosition.top,
        controller: controller,
        style: FlashStyle.grounded,
        boxShadows: kElevationToShadow[4],
        horizontalDismissDirection:
        HorizontalDismissDirection.horizontal,
        child: FlashBar(
          message: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
      );
    },
  );
}
void showErrorSnackBar(BuildContext context, String title) {
  showFlash(
    context: context,
    duration: Duration(seconds: 2),
    builder: (context, controller) {
      return Flash(
        backgroundColor: Colors.red,
        position: FlashPosition.top,
        controller: controller,
        style: FlashStyle.grounded,
        boxShadows: kElevationToShadow[4],
        horizontalDismissDirection:
        HorizontalDismissDirection.horizontal,
        child: FlashBar(
          message: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
      );
    },
  );
}


String shortenNumber(double value) {
  Display ds = createDisplay(
      separator: " ", decimal: 0, roundingType: RoundingType.floor, length: 4);

  return ds(value);
}

String formatDecimalToString(double value) {
  Display ds = createDisplay(
      separator: " ", decimal: 0, roundingType: RoundingType.floor);

  return ds(value);
}

String formatDecimalValue(double value) {
  Display ds = createDisplay(
      separator: " ", decimal: 2, roundingType: RoundingType.floor);

  return ds(value);
}

double calculateProgressBarValue(
    double purchasedTokenCount, double totalTokens) {
  try {
    if (purchasedTokenCount > 0 && totalTokens > 0) {
      return purchasedTokenCount / totalTokens;
    }
  } catch (e) {
    print(e);
  }

  return 0;
}

void openTwitch(String twitchName) async {
  try {
    var _url = "twitch://stream/$twitchName";
    var site_url = "https://www.twitch.tv/$twitchName";
    await canLaunch(_url) ? await launch(_url) : await launch(site_url);
  } catch (e) {
    print(e);
  }
}

//Firebase error codes...
// String getMessageFromErrorCode(BuildContext context, String errorCode) {
//   switch (errorCode) {
//
//     case "ERROR_EMAIL_ALREADY_IN_USE":
//     case "account-exists-with-different-credential":
//     case "email-already-in-use":
//
//       return AppLocalizations.of(context).firebase_error_email_already_in_use;
//       break;
//
//     case "ERROR_WRONG_PASSWORD":
//     case "wrong-password":
//       return AppLocalizations.of(context).firebase_error_wrong_password;
//       break;
//
//     case "ERROR_USER_NOT_FOUND":
//     case "user-not-found":
//       return AppLocalizations.of(context).firebase_error_user_not_found;
//       break;
//
//     case "ERROR_USER_DISABLED":
//     case "user-disabled":
//       return AppLocalizations.of(context).firebase_error_user_disabled;
//       break;
//
//     case "ERROR_TOO_MANY_REQUESTS":
//     case "operation-not-allowed":
//       return AppLocalizations.of(context).firebase_error_operation_not_allowed;
//       break;
//
//     case "ERROR_OPERATION_NOT_ALLOWED":
//     case "operation-not-allowed":
//       return AppLocalizations.of(context).firebase_error_operation_not_allowed;
//       break;
//
//     case "ERROR_INVALID_EMAIL":
//     case "invalid-email":
//       return AppLocalizations.of(context).email_error;
//       break;
//
//     default:
//       return AppLocalizations.of(context).error_something_went_wrong;
//       break;
//   }
// }
