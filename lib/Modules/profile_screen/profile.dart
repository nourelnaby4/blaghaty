import 'dart:io';
import 'package:blaghaty/Modules/profile_screen/cubit/profile_cubit.dart';
import 'package:blaghaty/main.dart';
import 'package:blaghaty/models/language_model.dart';
import 'package:blaghaty/shared/constants.dart';
import 'package:blaghaty/shared/shared/lang_helper/app_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbib_toast/tbib_toast.dart';

import '../../shared/shared/helper/colors_helper.dart';

class Profile extends StatelessWidget {
  var ssn = TextEditingController();
  var userName = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();
  var pin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserInfoProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ErrorOccurred) {
            Toast.show(state.errorMsg, context,
                gravity: Toast.bottom, duration: 2);
          }
          if (state is ChangePasswordSucces) {
            Toast.show('Password Has Been Changed Successfully', context,
                duration: 3);
          }
        },
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xffffa726),
              elevation: 1,
              centerTitle: true,
              leading: BackButton(),
              title: Text(
                  '${AppLocalization.of(context)!.translate('MyAccount')}'),
              actions: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: DropdownButton(
                    icon: Icon(Icons.language, color: Colors.white),
                    items: LanguageModel.languageList()
                        .map<DropdownMenuItem<LanguageModel>>(
                            (lang) => DropdownMenuItem(
                                  value: lang,
                                  child: Row(
                                    children: <Widget>[
                                      Text(lang.flag),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(lang.name)
                                    ],
                                  ),
                                ))
                        .toList(),
                    onChanged: (LanguageModel? value) {
                      changeLanguage(value, context);
                    },
                  ),
                ),
              ],
            ),
            body: state is LoadingUserInfoState
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 72,
                                        backgroundColor:
                                            ColorsManger.primaryColor,
                                      ),
                                      CircleAvatar(
                                        radius: 70,
                                        backgroundColor: Colors.white,
                                        backgroundImage: setImage(cubit),
                                      ),
                                    ],
                                  ),
                                  CircleAvatar(
                                    backgroundColor: ColorsManger.primaryColor,
                                    radius: 25,
                                    child: IconButton(
                                        onPressed: () {
                                          cubit.getProfileImage();
                                        },
                                        icon: Icon(Icons.camera_alt)),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            TextFormField(
                              controller: ssn
                                ..text = cubit.userModel!.ssn ?? '',
                              enabled: false,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "SSN",
                                prefixIcon: Icon(
                                  Icons.credit_card,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: userName
                                ..text = cubit.userModel!.name ?? '',
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.supervised_user_circle,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: phone
                                ..text = cubit.userModel!.phone ?? '',
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "+020",
                                prefixIcon: const Icon(
                                  Icons.phone,
                                ),
                                suffixIcon: TextButton(
                                  onPressed: () {
                                    if (phone.text !=
                                        '${cubit.userModel!.phone}') {
                                      cubit.changePhoneNumber(
                                          newPhone: phone.text);
                                    }
                                  },
                                  child: const Text(
                                    "Change",
                                    style: TextStyle(
                                        color: Color(0xff0D47A1), fontSize: 16),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: password
                                ..text = cubit.userModel!.password ?? '',
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: cubit.isPassword,
                              decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: const Icon(
                                  Icons.lock,
                                ),
                                suffixIcon: TextButton(
                                  onPressed: () {
                                    if (password.text !=
                                        '${cubit.userModel!.password}') {
                                      cubit.changeUserPassword(
                                          newPass: password.text,
                                          oldPass:
                                              '${cubit.userModel!.password}',
                                          email: '${cubit.userModel!.email}');
                                    }
                                  },
                                  child: const Text(
                                    "Change",
                                    style: TextStyle(
                                        color: Color(0xff0D47A1), fontSize: 16),
                                  ),
                                ),
                                /* suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changePassVisibilty();
                                  },
                                  icon: Icon(
                                    cubit.isPassword
                                        ? Icons.visibility_off
                                        : Icons.remove_red_eye,
                                  ),
                                ),*/
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password must be not empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: !cubit.isPassword,
                                  activeColor: ColorsManger.primaryColorDark,
                                  onChanged: (value) {
                                    cubit.changePassVisibilty();
                                  },
                                ),
                                Text("Show Password"),
                              ],
                            ),
                            const SizedBox(
                              height: 55,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed("home");
                                  },
                                  child: const Text("CANCEL",
                                      style: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 2.2,
                                          color: Colors.black)),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    cubit.updateUserData(map: {
                                      'ssn': ssn.text,
                                      'name': userName.text
                                    });
                                  },
                                  color: const Color(0xffffa726),
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Text(
                                    "SAVE",
                                    style: TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 2.2,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            )
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

  ImageProvider setImage(ProfileCubit cubit) {
    if ("${cubit.userModel!.image}" == ConstantManger.DEFULT) {
      return AssetImage('assets/LLL.jpg');
    } else {
      if (cubit.profileImage != null) {
        return FileImage(cubit.profileImage ?? File(''));
      } else {
        return NetworkImage(cubit.userModel!.image ?? '');
      }
    }
  }

  void changeLanguage(LanguageModel? value, context) {
    Locale local;
    switch (value!.languageCode) {
      case 'en':
        local = Locale(value.languageCode, 'US');
        break;
      case 'ar':
        local = Locale(value.languageCode, 'EG');
        break;
      default:
        local = Locale(value.languageCode, 'US');
        break;
    }
    MyApp.setLocales(context, local);
  }

// void showAwesomeDialog(context,) async {
//   await AwesomeDialog(
//     context: context,
//     animType: AnimType.SCALE,
//     dialogType: DialogType.INFO,
//     body: Column(
//       children: [
//         Center(
//           child: Text(
//             'Enter the code that sent to ${phone.text} ',
//             style: TextStyle(fontStyle: FontStyle.italic),
//           ),
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         PinCodeTextField(
//           controller: pin,
//           appContext: context,
//           autoFocus: true,
//           cursorColor: Colors.black,
//           keyboardType: TextInputType.number,
//           length: 6,
//           obscureText: false,
//           animationType: AnimationType.scale,
//           pinTheme: PinTheme(
//             shape: PinCodeFieldShape.box,
//             borderRadius: BorderRadius.circular(5),
//             fieldHeight: 50,
//             fieldWidth: 40,
//             borderWidth: 1,
//             activeColor: ColorsManger.primaryColor,
//             inactiveColor: ColorsManger.primaryColor,
//             inactiveFillColor: Colors.white,
//             activeFillColor: ColorsManger.primaryColorlight,
//             selectedColor: ColorsManger.primaryColor,
//             selectedFillColor: Colors.white,
//           ),
//           animationDuration: Duration(milliseconds: 300),
//           backgroundColor: Colors.white,
//           enableActiveFill: true,
//           onChanged: (String value) {},
//         )
//       ],
//     ),
//     btnOkOnPress: () {
//       //  ProfileCubit.get(context).submitOTP(pin.text);
//     },
//   )
//     ..show();
// }
}
