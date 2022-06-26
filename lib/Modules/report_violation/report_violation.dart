import 'dart:io';
import 'package:blaghaty/Modules/report_violation/components/drop_vio.dart';
import 'package:blaghaty/layout/main_layout/cubit/main_cubit.dart';
import 'package:blaghaty/models/report_model.dart';
import 'package:blaghaty/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blaghaty/shared/shared.component/components.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbib_toast/tbib_toast.dart';
import '../../shared/methods.dart';

class Report extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var dropvalue;
  var description = TextEditingController();

  String? cityName;
  String? stateName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Image(
                    image: AssetImage("assets/LLL.jpg"),
                    width: 200,
                    height: 200,
                  ),
                  // Problem Types
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    child: DropDownViolation(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Governorate
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 16, right: 16),
                      child: SelectState(
                          onCountryChanged: (value) {},
                          onStateChanged: (value) {
                            stateName = value;
                          },
                          onCityChanged: (value) {
                            cityName = value;
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Location in map
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 8,
                              child: Text(cubit.placeMark.isNotEmpty
                                  ? '${cubit.placeMark.first.street}'
                                  : "Location In Map")),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                cubit.getCurrentLocation();
                              },
                              icon: const Icon(Icons.location_on),
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Description
                  TextFormField(
                    controller: description,
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Description",
                    ),
                  ),
                  // Image
                  Row(
                    children: [
                      const Icon(Icons.camera_alt),
                      TextButton(
                          onPressed: () {
                            cubit.selectImage();
                          },
                          child: const Text(
                            "Select a photo",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 15),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  cubit.reportImage != null
                      ? Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                  cubit.reportImage ?? File('')))))
                      : Icon(Icons.camera),
                  const SizedBox(
                    height: 30,
                  ),
                  state is UploadReportImageLoading
                      ? LinearProgressIndicator()
                      :Container(),
                  const SizedBox(
                    height: 30,
                  ),
                  deffaultButton(
                      TextColor: Colors.white,
                      text: "Report a Violation",
                      function: () {
                        if (cubit.reportImage == null) {
                          Toast.show(
                              "Please Select Report Image", context,
                              duration: 2);
                        } else if (cubit.listitemText == null) {
                          Toast.show(
                              "Please Select Report Violation", context,
                              duration: 2);
                        } else {
                          if (cityName == null) {
                            if (cubit.placeMark.isNotEmpty) {
                              cubit.sendReport(
                                  reportModel: setUpReportModel(cubit: cubit,
                                    state: '${cubit.placeMark.first
                                        .administrativeArea}',
                                    city: '${cubit.placeMark.first
                                        .subAdministrativeArea} /  ${cubit
                                        .placeMark.first.locality}',));
                            } else {
                              Toast.show(
                                  'Error Please Choose Place', context,
                                  duration: 3);
                            }
                          } else {
                            if (cubit.placeMark.isNotEmpty) {
                              cubit.sendReport(
                                  reportModel:
                                  setUpReportModel(cubit: cubit,
                                    state: '${cubit.placeMark.first
                                        .administrativeArea}',
                                    city: '${cubit.placeMark.first
                                        .subAdministrativeArea} /  ${cubit
                                        .placeMark.first.locality}',));
                            }
                            else {
                              cubit.sendReport(reportModel: setUpReportModel(
                                  cubit: cubit,
                                  state: '${stateName}',
                                  city: '${cityName}'));
                            }
                          }
                        }
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ReportModel setUpReportModel(
      {required MainCubit cubit, required String state, required String city,}) {
    return ReportModel(
      senderId: FirebaseAuth.instance.currentUser!.uid,
      vio: cubit.listitemText,
      state: state,
      city: city,
      description: '${description.text}',
      image: ConstantManger.DEFULT,
      reportStatus: ConstantManger.Pending,
      date: setUpTodayDate(),
      reportCode: setUpReportCode(cubit: cubit),
    );
  }


}
