import 'package:blaghaty/Modules/adminpage/admin_page.dart';
import 'package:blaghaty/Modules/start_screen/start_screen.dart';
import 'package:blaghaty/shared/methods.dart';
import 'package:blaghaty/shared/shared/helper/colors_helper.dart';
import 'package:blaghaty/shared/shared/lang_helper/app_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/main_layout/main_layout.dart';
import 'cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..checkUserState(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoginState) {
            navigateToAndFinish(context, Start_screen());
          } else if (state is SplashHomeLayoutUserState) {
            navigateToAndFinish(context, MainLayout());
          } else if (state is SplashHomeLayoutAdminState) {
            navigateToAndFinish(context, AdminPageScreen(userModel:state.userModel ,));
          }
        },
        builder: (context, state) {

          return Scaffold(

            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 200),
                  Center(
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/LLL.jpg'))),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: CircularProgressIndicator(
                      color: ColorsManger.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
