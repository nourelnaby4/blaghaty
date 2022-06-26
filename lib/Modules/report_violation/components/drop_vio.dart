import 'package:blaghaty/layout/main_layout/cubit/main_cubit.dart';
import 'package:blaghaty/layout/main_layout/cubit/main_cubit.dart';
import 'package:blaghaty/layout/main_layout/cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DropDownViolation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              '  Select Violation',
              style: TextStyle(
                fontSize: 20,
                color: Theme
                    .of(context)
                    .hintColor,
              ),
            ),
            items: MainCubit.get(context).listitem
                .map((item) =>
                DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize:20,
                    ),
                  ),
                ))
                .toList(),
            value: MainCubit.get(context).listitemText,
            onChanged: (value) {
              MainCubit.get(context).chooseListItem(value as String);
            },
            buttonHeight: 50,
            buttonWidth: 240,
            itemHeight: 60.0,
          ),
        );
      },
    );
  }
}