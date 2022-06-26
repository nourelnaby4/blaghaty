import 'package:blaghaty/shared/shared/helper/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/nav_bar.dart';
import 'cubit/main_cubit.dart';

class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context)..getUserInfoProfile();
          return Scaffold(
            drawer: NavBar(mainCubit: cubit,),
            appBar: AppBar(
              elevation: 2,
              leading: Builder(builder: (context) {
                return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.format_list_bulleted_outlined),
                  iconSize: 30,
                  color: Colors.black,
                );
              }),
              centerTitle: true,
              title: Text(
                '${cubit.title[cubit.currentIndex]}',
                style: TextStyle(color: Colors.black, letterSpacing: 1.5),
              ),
            ),
            body: cubit.screensList[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.support_agent),
              backgroundColor: ColorsManger.primaryColorDark,
            ),
            bottomNavigationBar:BottomNavigationBar(
              selectedItemColor: ColorsManger.primaryColorDark,
              items: cubit.list,
              onTap: (index){
                cubit.changeBottomNav(index);
              },
              currentIndex: cubit.currentIndex,
            )
            /*ConvexAppBar(
              activeColor: Colors.grey,
              backgroundColor: ColorsManger.primaryColorDark,
              color: Colors.white,
              items:cubit.bottomNavItems,
              onTap: (int index) {
                cubit.changeBottomNav(index);
              },
              initialActiveIndex: cubit.currentIndex,
            ),*/
          );
        },
      ),
    );
  }
}
