import 'dart:io';
import 'package:blaghaty/Modules/history/history.dart';
import 'package:blaghaty/Modules/home_screen/home_screen.dart';
import 'package:blaghaty/Modules/report_violation/report_violation.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../../models/report_model.dart';
import '../../../models/user_model.dart';
import '../../../shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../shared/services/network/dio_helper.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  //////////////////////////////////////////////////////////////////////////////
  int currentIndex = 0;
  List<Widget> screensList = [
    HomeScreen(),
    Report(),
    History(),
  ];
  List<BottomNavigationBarItem> list = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.add), label: 'Add'),
    BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
  ];
  List<String> title = ['Home', "Report Violation", 'History'];

  void changeBottomNav(int index) {
    this.currentIndex = index;
    if (index == 2) {
      getHistoryReport();
    }
    emit(ChangeBottomNavIndexState());
  }

  int currentIndicator = 0;

  void changeIndicator(int index) {
    this.currentIndicator = index;
    emit(ChangeIndicatorIndexState());
  }


  UserModel ? userModel;

  void getUserInfoProfile() {
    FirebaseFirestore.instance
        .collection(ConstantManger.USERS)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots().listen((user) {
      userModel = UserModel.fromJson(user.data() ?? {});
    });
  }

  //////////////////////////////////////////////////////////////////////
  String? listitemText;

  List listitem = [
    ConstantManger.Merror,
    ConstantManger.Hawadeth,
    ConstantManger.Torok,
    ConstantManger.Enara,
    ConstantManger.HalatNesa2ya,
    ConstantManger.Amtar,
  ];

  void chooseListItem(String commingListText) {
    this.listitemText = commingListText;
    emit(ReportChooseListItem());
  }

  var _picker = ImagePicker();
  File? reportImage;

  Future selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      reportImage = File(pickedFile.path);
      emit(ChosseImageSuccesState());
    } else {
      print('No Image Selected');
    }
  }

  List<Placemark> placeMark = [];

  void getCurrentLocation() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.requestPermission();

      LocationPermission permission;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        emit(LocationPerrmisionDeniedState());
      }
    }
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((value) async {
      await placemarkFromCoordinates(value.latitude, value.longitude)
          .then((value) {
        placeMark.addAll(value);
        print(placeMark.first);
        emit(LocationPerrmisionAcceptedState());
      });
    });
  }

  List<UserModel> adminList = [];

  void sendReport({required ReportModel reportModel}) {
    emit(UploadReportImageLoading());
    FirebaseFirestore.instance
        .collection(ConstantManger.Reports)
        .add(reportModel.toMap())
        .then((value) {
      uploadReportImage(id: value.id,reportCode: reportModel.reportCode??0);
    });
  }

  void uploadReportImage({required String id ,  required int reportCode}) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
        '${ConstantManger.Reports}${Uri
            .file(reportImage!.path)
            .pathSegments
            .last}')
        .putFile(reportImage ?? File(''))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection(ConstantManger.Reports)
            .doc(id)
            .update({'image': value, 'id': id});
      }).then((value) {
        emit(UploadImageSuccess());
         sendNotification(reportCode: reportCode);
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  void sendNotification({required int reportCode}) {
    FirebaseFirestore.instance
        .collection(ConstantManger.USERS)
        .where('isAdmin', isEqualTo: true)
        .get()
        .then((value) {
      value.docs.forEach((user) {
        if(user.data()['adminCode'] ==reportCode ){
           final data = {
          "to": "${user.data()['token']}",
          "notification": {
            "body": "",
            "title": "Recevice new Report",
            "sound": "default"
          },
          "android": {
            "priority": "HIGH",
            "notification": {
              "notification_priority": "PRIORITY_HIGH",
              "sound": "default",
              "default_sound": true,
              "default_vibrate_timings": true,
              "default_light_settings": true,
            },
          },
          "data": {
            "type": "order",
            "id": "87",
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
          }
        };
        DioHelper().postData(path: 'fcm/send', data: data).then((value) {
          if (value.statusCode == 200) {
            print('sent done');
          }
        }).catchError((error) {
          print(error.toString());
          emit(SendNotiFaild());
        });
        }
      });
    });
  }

  ///////////////////////////////////////////////////////////////////////

  List<ReportModel> reportModelList = [];

  void getHistoryReport() {
    emit(GetHistortLoading());
    FirebaseFirestore.instance
        .collection(ConstantManger.Reports)
        .where('senderId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      reportModelList.clear();
      value.docs.forEach((element) {
        reportModelList.add(ReportModel.fromJson(element.data()));
      });
      emit(GetHistortSuccess());
    }).catchError((error) {
      print(error.toString());
    });
  }

  void updateReport(int reportCode, String id) {
    switch (reportCode) {
      case 10:
        _updateReport(newCode: 11, id: id);
        break;
      case 11:
        _updateReport(newCode: 12, id: id);
        break;
      case 12:
        _updateReport(newCode: 40, id: id);
        break;

      case 20:
        _updateReport(newCode: 21, id: id);
        break;
      case 21:
        _updateReport(newCode: 22, id: id);
        break;
      case 22:
        _updateReport(newCode: 23, id: id);
        break;
      case 23:
        _updateReport(newCode: 24, id: id);
        break;
      case 24:
        _updateReport(newCode: 25, id: id);
        break;
      case 25:
        _updateReport(newCode: 26, id: id);
        break;
      case 26:
        _updateReport(newCode: 40, id: id);
        break;

      case 30:
        _updateReport(newCode: 31, id: id);
        break;
      case 31:
        _updateReport(newCode: 32, id: id);
        break;
      case 32:
        _updateReport(newCode: 40, id: id);
        break;

      case 40:
        //emit(Fininsh());
        break;
    }
  }

  //private
  void _updateReport({required int newCode, required String id}) {
    FirebaseFirestore.instance
        .collection(ConstantManger.Reports)
        .doc(id)
        .update({'reportCode': newCode});
  }

  //////////////////////////////////////////////
  void signOut(){
    FirebaseAuth.instance.signOut().then((value) {
      emit(SignOutSuccess());
    });
  }
  /////////////////////////////////////////

void deleteReport(String id){
    FirebaseFirestore.instance.collection(ConstantManger.Reports).doc(id).delete();
}
}
