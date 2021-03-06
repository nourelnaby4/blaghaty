import 'package:blaghaty/shared/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blaghaty/shared/shared.component/components.dart';

import '../../models/user_model.dart';
import '../../shared/constants.dart';

// ignore: camel_case_types
class Start_screen extends StatefulWidget {
  const Start_screen({Key? key}) : super(key: key);

  @override
  _Start_screenState createState() => _Start_screenState();
}

// ignore: camel_case_types
class _Start_screenState extends State<Start_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${setUpTranslate(context, 'Welcome')}',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image(
                  image: AssetImage("assets/LLL.jpg"),
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: const Color(0xffffa726),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0))),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      deffaultButton(
                        function: () {
                          Navigator.of(context).pushNamed("signin");
                        },
                        text: "${setUpTranslate(context, 'signIn')}",
                        background: Colors.white,
                        TextColor: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      deffaultButton(
                        function: () {
                          Navigator.of(context).pushNamed("signup");
                        },
                        text: "${setUpTranslate(context, 'signUp')}",
                        background: Colors.white,
                        TextColor: Colors.black,
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
