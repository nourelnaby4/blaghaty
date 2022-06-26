import 'package:blaghaty/models/user_model.dart';
import 'package:blaghaty/shared/constants.dart';
import 'package:blaghaty/shared/services/local/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  void checkUserState() {
    Future.delayed(Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((currentUser) {
        if (currentUser != null) {
          int code = CachedHelper.getInt(key: "code") ?? 100;

          if (code == 100) {
            emit(SplashHomeLayoutUserState());
          } else {
            print(code);
            FirebaseFirestore.instance
                .collection(ConstantManger.USERS)
                .where("adminCode", isEqualTo: code)
                .get()
                .then((value) {
              UserModel userModel = UserModel.fromJson(value.docs.first.data());
              emit(SplashHomeLayoutAdminState(userModel: userModel));
            });
          }
        } else {
          emit(SplashLoginState());
        }
      });
    });
  }
}
