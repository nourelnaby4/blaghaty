import 'package:blaghaty/Modules/sign_in/cubit/sign_in_state.dart';
import 'package:blaghaty/models/user_model.dart';
import 'package:blaghaty/shared/constants.dart';
import 'package:blaghaty/shared/services/local/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  static SignInCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void changePassVisibilty() {
    this.isPassword = !isPassword;
    emit(ChangePasswordState());
  }

  Future signInWithEmailAndPassword({
    required String email,
    required String password,
    int? code,
  }) async {
    emit(SignInLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) async {
          if(code ==600){
            //user
            FirebaseFirestore.instance
                .collection(ConstantManger.USERS)
                .doc(user.user!.uid)
                .update({
              'uid': user.user!.uid,
            }).then((value){
              emit(SignInSuccessStateUserMainLayout());
            });
          }else{
            //admin
            FirebaseFirestore.instance
                .collection(ConstantManger.USERS)
                .where("adminCode", isEqualTo: code)
                .get()
                .then((value) {
                  CachedHelper.saveData(key: "code", value: code);
              UserModel userModel = UserModel.fromJson(value.docs.first.data());
              emit(SignInSuccessStateAdminMainLayout(userModel: userModel));
            });
          }
    });
  }

  List<bool> isAdminList = [true, false];

  void changeToggleState(int index) {
    if (index == 0) {
      isAdminList[0] = true;
      isAdminList[1] = false;
      print('Admin');
    } else {
      isAdminList[0] = false;
      isAdminList[1] = true;
      print('user');
    }
    emit(ChangeToggleState());
  }
}
