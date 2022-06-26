import 'package:blaghaty/Modules/sign_in/cubit/sign_in_cubit.dart';
import 'package:blaghaty/Modules/sign_up/cubit/regsiter_cubit.dart';
import 'package:blaghaty/shared/methods.dart';
import 'package:flutter/material.dart';
class CustomToggleButtonDesign extends StatelessWidget {

  SignInCubit _cubit;

  CustomToggleButtonDesign(this._cubit);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.all(20),
          child: Row(
            children: [
              Text('${setUpTranslate(context, 'admin')}',style: TextStyle(fontSize: 20.0),),
              SizedBox(height: 10.0,),
              Icon(Icons.admin_panel_settings_outlined),
            ],
          ),
        ),
        Padding(
          padding:  EdgeInsets.all(20),
          child: Row(
            children: [
              Text('${setUpTranslate(context, "user")}',style: TextStyle(fontSize: 20.0),),
              SizedBox(height: 10.0,),
              Icon(Icons.supervised_user_circle_rounded),
            ],
          ),
        ),

      ],
      onPressed: (int index) {
        _cubit.changeToggleState(index);
      },
      isSelected: _cubit.isAdminList,
    );
  }
}
