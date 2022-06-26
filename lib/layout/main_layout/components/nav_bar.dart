import 'package:blaghaty/Modules/adminpage/cubit/admin_cubit.dart';
import 'package:blaghaty/Modules/sign_in/sign_in.dart';
import 'package:blaghaty/layout/main_layout/cubit/main_cubit.dart';
import 'package:blaghaty/main.dart';
import 'package:blaghaty/models/user_model.dart';
import 'package:blaghaty/shared/constants.dart';
import 'package:blaghaty/shared/methods.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  MainCubit ? mainCubit;
  UserModel ? userModel;

  NavBar({this.mainCubit  , this.userModel});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          mainCubit !=null ?
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image(
                  image: mainCubit!.userModel!.image != ConstantManger.DEFULT
                      ? NetworkImage('${mainCubit!.userModel!.image}')
                      : AssetImage('assets/LLL.jpg') as ImageProvider,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            accountName: Text(
              '${mainCubit!.userModel!.name}',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            accountEmail: Text('${mainCubit!.userModel!.email}',
                style: TextStyle(
                  color: Colors.black,
                )),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/64/57/ab/6457ab824bbd9983b24d52bf750fc2f9.jpg')),
            ),
          ):
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image(
                  image: userModel!.image != ConstantManger.DEFULT
                      ? NetworkImage('${userModel!.image}')
                      : AssetImage('assets/LLL.jpg') as ImageProvider,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            accountName: Text(
              '${userModel!.name}',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            accountEmail: Text('${userModel!.email}',
                style: TextStyle(
                  color: Colors.black,
                )),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/64/57/ab/6457ab824bbd9983b24d52bf750fc2f9.jpg')),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Color(0xff0D47A1),
            ),
            title: const Text('My Account'),
            onTap: () {
              Navigator.of(context).pushNamed("profile");
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.language,
              color: Color(0xff0D47A1),
            ),
            title: const Text('Language'),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(
              Icons.help,
              color: Color(0xff0D47A1),
            ),
            title: Text('help'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.login_rounded,
              color: Color(0xff0D47A1),
            ),
            title: const Text('Logout'),
            onTap: () {
              navigateToAndFinish(context, LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
