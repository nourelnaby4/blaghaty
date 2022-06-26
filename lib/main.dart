import 'package:blaghaty/Modules/history/history.dart';
import 'package:blaghaty/Modules/splash_screen/splash_screen.dart';
import 'package:blaghaty/Modules/start_screen/start_screen.dart';
import 'package:blaghaty/shared/services/local/cache_helper.dart';
import 'package:blaghaty/shared/services/network/dio_helper.dart';
import 'package:blaghaty/shared/shared/helper/bloc_observer.dart';
import 'package:blaghaty/shared/shared/helper/colors_helper.dart';
import 'package:blaghaty/shared/shared/lang_helper/app_local.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Modules/forget_password/forget_password.dart';
import 'Modules/profile_screen/profile.dart';
import 'Modules/report_violation/report_violation.dart';
import 'Modules/resetpassword.dart';
import 'Modules/sign_in/sign_in.dart';
import 'Modules/sign_up/sign_up.dart';
import 'layout/main_layout/main_layout.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  BlocOverrides.runZoned(
    () async{
      WidgetsFlutterBinding.ensureInitialized();
      await CachedHelper.init();
      await Firebase.initializeApp();
      DioHelper.init();

      ////////////////////////////////////////////////////////////
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {

static void setLocales(BuildContext context , Locale locale){
  _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();

  state!.setLocale(locale);
}
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  Locale ? _locale;

  void setLocale(Locale locale){
    setState(() {
      _locale = locale;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: .0,
          color: ColorsManger.primaryColorDark,
          titleTextStyle: TextStyle(color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: ColorsManger.primaryColorDark,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: ColorsManger.primaryColorDark,
            primary: ColorsManger.primaryColorDark),
        scaffoldBackgroundColor: Colors.white,
      ),
      locale: _locale,
      routes: {
        "signup": (context) => Register(),
        "signin": (context) => LoginScreen(),
        "home": (context) => MainLayout(),
        "report": (context) => Report(),
        "profile": (context) => Profile(),
        "forgetpassword": (context) => ForgetPassword(),
        "reset": (context) => ResetPassword(),
        "history": (context) => History(),
      },
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("en", "US"),
        Locale("ar", "EG"),
      ],

      localeResolutionCallback: (locale, supportLang) {
        for (var suportedLocal in supportLang) {
          if (suportedLocal.languageCode == locale!.languageCode &&
              suportedLocal.countryCode == locale.countryCode) {
            return suportedLocal;
          }
        }
        return supportLang.first;
      },
    );
  }
}
