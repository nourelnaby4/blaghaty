import 'package:blaghaty/shared/constants.dart';

class UserModel {
  String? ssn;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? uid;
  String? image;
  int ? adminCode;
  bool ? isAdmin;

  UserModel({
    this.uid = ConstantManger.DEFULT,
    required this.ssn,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.image,
    this.adminCode,
    this.isAdmin=false
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    ssn = json['ssn'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    uid = json['uid'];
    image = json['image'];
    adminCode= json['adminCode'];
    isAdmin=json["isAdmin"];
  }

  Map<String, dynamic> toMap() {
    return {
      'ssn': ssn,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'uid': uid,
      'image': image,
      'adminCode':adminCode,
      "isAdmin":isAdmin,
    };
  }
}
