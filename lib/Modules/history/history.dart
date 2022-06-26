import 'package:blaghaty/Modules/history/compentes/custom_report_card.dart';
import 'package:blaghaty/layout/main_layout/cubit/main_cubit.dart';
import 'package:blaghaty/shared/methods.dart';
import 'package:blaghaty/shared/shared/lang_helper/app_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return state is GetHistortLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : MainCubit.get(context).reportModelList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => CustomReportCard(
                          reportModel:
                              MainCubit.get(context).reportModelList[index]),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 10,
                      ),
                      itemCount: MainCubit.get(context).reportModelList.length,
                    ))
                : Center(
                    child: Text('${setUpTranslate(context, 'noReports')}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  );
      },
    );
  }
/*Widget Violations() =>
      Container(
        decoration: BoxDecoration(
          color: Color(0xffffa726),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              offset: Offset(1, 5),
            ),
          ],
          image: const DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://gorillapdf.com/blog/15-tips-to-go-paperless-at-work/protect-the-environment-by-going-paperless.png')),
        ),
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Violation Type',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Text(
                    'Date: 20/10/2022',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );*/
}
