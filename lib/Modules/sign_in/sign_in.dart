import 'package:blaghaty/Modules/sign_in/cubit/sign_in_cubit.dart';
import 'package:blaghaty/Modules/sign_in/cubit/sign_in_state.dart';
import 'package:blaghaty/Modules/sign_in/toggle_button_design.dart';
import 'package:blaghaty/layout/main_layout/main_layout.dart';
import 'package:blaghaty/shared/shared/lang_helper/app_delegate.dart';
import 'package:blaghaty/shared/shared/lang_helper/app_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blaghaty/shared/shared.component/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/methods.dart';
import '../adminpage/admin_page.dart';

class LoginScreen extends StatelessWidget {
  var emailControler = TextEditingController();
  var PasswordControler = TextEditingController();
  var adminCode = TextEditingController();
  var formkey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInLoadingState) {
            showCustomProgressIndicator(context);
          } else if (state is SignInFailuerState) {
            Navigator.pop(context);
            String errorMsg = state.error;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 5),
            ));
          } else if (state is SignInSuccessStateUserMainLayout) {
            Navigator.pop(context);
            navigateToAndFinish(context, MainLayout());
          } else if (state is SignInSuccessStateAdminMainLayout) {
            Navigator.pop(context);
            navigateToAndFinish(
                context,
                AdminPageScreen(
                  userModel: state.userModel,
                ));
          }
        },
        builder: (context, state) {
          SignInCubit cubit = SignInCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Image(
                            image: AssetImage("assets/LLL.jpg"),
                            width: 200,
                            height: 200,
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: emailControler,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText:
                              "${AppLocalization.of(context)!.translate('emailaddress')}",
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'email must be not empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: PasswordControler,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: cubit.isPassword,
                        decoration: InputDecoration(
                          hintText:
                              "${AppLocalization.of(context)!.translate('password')}",
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changePassVisibilty();
                            },
                            icon: Icon(
                              isPassword
                                  ? Icons.visibility_off
                                  : Icons.remove_red_eye,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password must be not empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomToggleButtonDesign(cubit),
                      const SizedBox(
                        height: 20.0,
                      ),
                      cubit.isAdminList[0]
                          ? TextFormField(
                              controller: adminCode,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Admin Code",
                                prefixIcon: const Icon(
                                  Icons.lock,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Admin Code must be not empty';
                                }
                                return null;
                              },
                            )
                          : Center(),
                      const SizedBox(
                        height: 50,
                      ),
                      deffaultButton(
                        function: () {
                          if (formkey.currentState!.validate()) {
                            cubit.signInWithEmailAndPassword(
                              code:cubit.isAdminList[0]?int.parse(adminCode.text):600,
                                email: emailControler.text,
                                password: PasswordControler.text);
                          }
                        },
                        text:
                            "${AppLocalization.of(context)!.translate('signIn')}",
                        TextColor: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("forgetpassword");
                            },
                            child: Text(
                              "${AppLocalization.of(context)!.translate('forgetPassword')}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${AppLocalization.of(context)!.translate('donthaveaccout')}",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("signup");
                            },
                            child: Text(
                              "${AppLocalization.of(context)!.translate('signUp')}",
                              style: TextStyle(
                                color: Color(0xff0D47A1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
