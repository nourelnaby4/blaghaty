import 'package:blaghaty/Modules/adminpage/cubit/admin_cubit.dart';
import 'package:blaghaty/models/report_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomRequestCard extends StatelessWidget {
  ReportModel reportModel;


  CustomRequestCard({required this.reportModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        AdminCubit cubit = AdminCubit.get(context);
        return Card(
          elevation: 20,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 17,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 8,
                ),
                Text('Violation : ${reportModel.vio}', style: TextStyle(fontSize: 18)),
                Text('Description : ${reportModel.description}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 8,
                ),
                Text('City : ${reportModel.city}', style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 8,
                ),
                Text('Date : ${reportModel.date}', style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: buildButton(
                          context: context,
                          onPress: () {
                            cubit.replyReport(accept: true, id: "${reportModel.id}");
                          },
                          text: 'Accept',
                          type: 'Accept'),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: buildButton(
                          context: context,
                          onPress: () {
                            cubit.replyReport(accept: false, id: "${reportModel.id}");
                          },
                          text: 'Reject',
                          type: 'Reject'),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildButton(
      {required context,
      required String text,
      required onPress,
      required String type}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: setUpColor(type),
      ),
      child: MaterialButton(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
              ),
        ),
        onPressed: onPress,
      ),
    );
  }

  Color setUpColor(String type) {
    if (type == 'Accept') return Colors.green;
    if (type == 'Reject')
      return Colors.red;
    else {
      return Colors.grey;
    }
  }
}
