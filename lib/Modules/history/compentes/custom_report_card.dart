import 'package:blaghaty/layout/main_layout/cubit/main_cubit.dart';
import 'package:blaghaty/models/report_model.dart';
import 'package:blaghaty/shared/constants.dart';
import 'package:blaghaty/shared/shared.component/components.dart';
import 'package:blaghaty/shared/shared/helper/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomReportCard extends StatelessWidget {
  CustomReportCard({required this.reportModel});

  ReportModel reportModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Dismissible(
          key: Key("${reportModel.id}"),
          onDismissed: (direcation) {
            MainCubit.get(context).deleteReport(reportModel.id ?? '');
          },
          child: Card(
            elevation: 12,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 17,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Date : ${reportModel.date}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Violation : ${reportModel.vio}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Description : ${reportModel.description}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text('Report Status : ', style: TextStyle(fontSize: 18)),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text("${reportModel.reportStatus}",
                          style: TextStyle(fontSize: 18)),
                      Icon(setUpIcon("${reportModel.reportStatus}")),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  reportModel.reportCode != 40
                      ? deffaultButton(
                          TextColor: Colors.white,
                          text: 'Escalate',
                          function: () {
                            MainCubit.get(context).updateReport(
                                reportModel.reportCode ?? 0,
                                reportModel.id ?? '');
                          },
                        )
                      : Text('Report Sent to cabinet',
                          style: TextStyle(
                            color: ColorsManger.primaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  IconData? setUpIcon(String statue) {
    if (statue == ConstantManger.Pending) {
      return Icons.report;
    } else if (statue == 'accept') {
      return Icons.check;
    } else {
      return Icons.close;
    }
  }

/*Widget buildButton(context, String text, onPress, bool accept) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateScreenHeight(10.0)),
        color: accept ? Colors.green : Colors.red,
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

  Widget buildText(BuildContext context, String text) {
    return Text(
      '${text}',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: getProportionateScreenWidth(16.0),
      ),
    );
  }*/
}
