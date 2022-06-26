import 'package:blaghaty/shared/shared/helper/colors_helper.dart';
import 'package:blaghaty/shared/shared/lang_helper/app_delegate.dart';
import 'package:blaghaty/shared/shared/lang_helper/app_local.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../layout/main_layout/cubit/main_cubit.dart';
import 'constants.dart';

void showCustomProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = const AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ColorsManger.primaryColor),
      ),
    ),
  );

  showDialog(
    barrierColor: Colors.white.withOpacity(0),
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void navigateToWithAnimation(context, widget) {
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, _) {
            return FadeTransition(
              opacity: animation,
              child: widget,
            );
          }));
}

String setUpTodayDate() {
  return DateFormat.yMMMEd().format(DateTime.now());
}

int setUpReportCode({MainCubit? cubit, String? adminDec}) {
  if (cubit != null) {
    if (cubit.listitemText == ConstantManger.Merror ||
        cubit.listitemText == ConstantManger.Hawadeth) {
      return 10;
    } else if (cubit.listitemText == ConstantManger.Torok ||
        cubit.listitemText == ConstantManger.Bena2 ||
        cubit.listitemText == ConstantManger.Qemama ||
        cubit.listitemText == ConstantManger.Enara ||
        cubit.listitemText == ConstantManger.Amtar) {
      return 20;
    } else {
      return 30;
    }
  } else {
    if (adminDec == ConstantManger.Merror1)
      return 10;
    else if (adminDec == ConstantManger.Merror2)
      return 11;
    else if (adminDec == ConstantManger.Merror3)
      return 12;
    else if (adminDec == ConstantManger.Wehda1)
      return 20;
    else if (adminDec == ConstantManger.Wehda2)
      return 21;
    else if (adminDec == ConstantManger.Wehda3)
      return 22;
    else if (adminDec == ConstantManger.Wehda4)
      return 23;
    else if (adminDec == ConstantManger.Wehda5)
      return 24;
    else if (adminDec == ConstantManger.Wehda6)
      return 25;
    else if (adminDec == ConstantManger.Wehda7)
      return 26;
    else if (adminDec == ConstantManger.Shorta1)
      return 31;
    else if (adminDec == ConstantManger.Shorta2)
      return 32;
    else if (adminDec == ConstantManger.Shorta3)
      return 33;
    else {
      return 40;
    }
  }
}

String setUpTranslate(context, String key) {
  return AppLocalization.of(context)!.translate(key) ?? '';
}
