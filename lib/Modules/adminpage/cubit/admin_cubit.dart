import 'package:blaghaty/models/report_model.dart';
import 'package:blaghaty/shared/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/user_model.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  static AdminCubit get(BuildContext context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserInfoProfile() {
    FirebaseFirestore.instance
        .collection(ConstantManger.USERS)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((user) {
      userModel = UserModel.fromJson(user.data() ?? {});
    });
  }

  List<ReportModel> listReports = [];

  void getReport(int adminCode) {
    emit(GetReportsLoading());
    FirebaseFirestore.instance
        .collection(ConstantManger.Reports)
        .where('reportCode', isEqualTo: adminCode)
        .snapshots()
        .listen((value) {
          listReports.clear();
          value.docs.forEach((report) {
            if(report.data()['reportStatus'] == '${ConstantManger.Pending}')
            listReports.add(ReportModel.fromJson(report.data()));
          });
          emit(GetReportsSuccess());
        });
  }



  void replyReport({required bool accept, required String id }) {
    FirebaseFirestore.instance
        .collection(ConstantManger.Reports)
        .doc(id)
        .update({'reportStatus': accept ? 'accept' : 'reject'}).then((value) {
    });
  }
}
