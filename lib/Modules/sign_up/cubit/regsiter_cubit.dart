import 'package:blaghaty/Modules/sign_up/cubit/register_state.dart';
import 'package:blaghaty/shared/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);


  bool? ssnChecker;
  List<UserModel> lss = [];

  void regiterNewUser({required UserModel userModel}){
    emit(RegisterLoadingState());
    FirebaseFirestore.instance
        .collection(ConstantManger.USERS)
        .where('ssn', isEqualTo: userModel.ssn)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: userModel.email ?? '',
                  password: userModel.password ?? '')
              .then((value) {
            FirebaseFirestore.instance
                .collection(ConstantManger.USERS)
                .doc(value.user!.uid)
                .set(userModel.toMap());
          });
          emit(RegisterSuccessState());
        } catch (e) {
          emit(RegisterFailuerState(e.toString()));
        }
      }else{
        emit(RegisterErrorSSN());
      }
    });
  }



  String? adminDescrition;
  List<String> adminDescriptionList = [
    ConstantManger.Merror1,
    ConstantManger.Merror2,
    ConstantManger.Merror3,
    ConstantManger.Wehda1,
    ConstantManger.Wehda2,
    ConstantManger.Wehda3,
    ConstantManger.Wehda4,
    ConstantManger.Wehda5,
    ConstantManger.Wehda6,
    ConstantManger.Wehda7,
    ConstantManger.Shorta1,
    ConstantManger.Shorta3,
  ];


}
