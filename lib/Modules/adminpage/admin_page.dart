import 'package:blaghaty/Modules/adminpage/cubit/admin_cubit.dart';
import 'package:blaghaty/layout/main_layout/components/nav_bar.dart';
import 'package:blaghaty/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/custom_request_card.dart';

class AdminPageScreen extends StatelessWidget {
  UserModel userModel;

  AdminPageScreen({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit()..getReport(userModel.adminCode??0),
      child: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              drawer: NavBar(userModel: userModel),
              appBar: AppBar(
                title: const Text(
                  'Admin Panal',
                  style: TextStyle(color: Colors.black, letterSpacing: 1.5),
                ),
                centerTitle: true,
              ),
              body: state is GetReportsLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : AdminCubit.get(context).listReports.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => CustomRequestCard(
                                reportModel:
                                    AdminCubit.get(context).listReports[index]),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 10,
                            ),
                            itemCount:
                                AdminCubit.get(context).listReports.length,
                          ))
                      : const Center(
                          child: Text('No Reports',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ));
        },
      ),
    );
  }
}
