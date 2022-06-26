import 'package:blaghaty/Modules/sign_up/cubit/register_state.dart';
import 'package:blaghaty/Modules/sign_up/cubit/regsiter_cubit.dart';
import 'package:blaghaty/models/user_model.dart';
import 'package:blaghaty/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blaghaty/shared/shared.component/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbib_toast/tbib_toast.dart';
import '../../shared/methods.dart';

class Register extends StatelessWidget {
  // ignore: non_constant_identifier_names
  var SSN = TextEditingController();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var phoneNumber = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoadingState)
            showCustomProgressIndicator(context);
          else if (state is RegisterSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            Toast.show('Success Register', context, gravity: Toast.bottom,duration: 3);
          } else if (state is RegisterFailuerState) {
            Navigator.pop(context);
            String errorMsg = state.errorMsg;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ));
          }else if(state is RegisterErrorSSN){
            Navigator.pop(context);
            Toast.show('SSN Already Used', context,duration: 3);
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                         Text(
                          "${setUpTranslate(context, 'signUp')}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: SSN,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "${setUpTranslate(context, 'ssn')}",
                            prefixIcon: Icon(
                              Icons.credit_card,
                              color: Color(0xff0D47A1),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${setUpTranslate(context, 'ssnvalidate')}';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: name,
                          keyboardType: TextInputType.name,
                          decoration:  InputDecoration(
                            hintText: "${setUpTranslate(context, 'name')}",
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color(0xff0D47A1),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${setUpTranslate(context, 'namevalidate')}';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration:  InputDecoration(
                            hintText: "${setUpTranslate(context, 'mail')}",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xff0D47A1),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${setUpTranslate(context, 'mailvalidate')}';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: password,
                          keyboardType: TextInputType.text,
                          decoration:  InputDecoration(
                            hintText: "${setUpTranslate(context, 'password')}",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff0D47A1),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${setUpTranslate(context, 'passwordvalidate')}';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: confirmPassword,
                          keyboardType: TextInputType.text,
                          decoration:  InputDecoration(
                            hintText: "${setUpTranslate(context, 'ConfirmPassword')}",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff0D47A1),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${setUpTranslate(context, 'ConfirmPasswordValidate')}';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: phoneNumber,
                          keyboardType: TextInputType.number,
                          decoration:  InputDecoration(
                            hintText: "${setUpTranslate(context, 'PhoneNumber')}",
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Color(0xff0D47A1),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${setUpTranslate(context, 'PhoneNumberValidate')}';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        deffaultButton(
                          function: () {
                            if (formkey.currentState!.validate()) {
                              if (SSN.text.length == 14) {
                                cubit.regiterNewUser(
                                    userModel: UserModel(
                                      isAdmin: false,
                                        uid: ConstantManger.DEFULT,
                                        adminCode: 1,
                                        image: ConstantManger.DEFULT,
                                        ssn: SSN.text,
                                        name: name.text,
                                        email: email.text,
                                        password: password.text,
                                        phone: phoneNumber.text,
                                    ));
                              } else {
                                Toast.show('SSN Must Be 14 number', context,
                                    duration: 2, backgroundColor: Colors.red);
                              }
                            }
                          },
                          text: "Sign Up",
                          TextColor: Colors.white,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("signin");
                          },
                          child: const Text(
                            "Already have an account",
                            style: TextStyle(
                              color: Color(0xff0D47A1),
                            ),
                          ),
                        ),
                      ],
                    ),
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
