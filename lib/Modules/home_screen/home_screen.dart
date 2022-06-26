import 'package:blaghaty/shared/methods.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/main_layout/cubit/main_cubit.dart';
import '../emergency_screen/emergency_numbers.dart';
import 'components/imageview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: const Image(
                        image: AssetImage("assets/LLL.jpg"),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Text(
                      'Blaghaty',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1.5),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        offset: Offset(1, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://i.pinimg.com/originals/64/57/ab/6457ab824bbd9983b24d52bf750fc2f9.jpg')),
                  ),
                  width: double.infinity,
                  height: 240,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome To Blaghaty',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 1.2),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Make Your city clean',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 50),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            MainCubit.get(context).changeBottomNav(1);
                          },
                          child: const Text("Take Photo and Send",
                              style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.5,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 230,
                  width: double.infinity,
                  child: CarouselSlider(
                    items: appBannerList
                        .map((e) => Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('${e.url}'),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      onPageChanged: (int index, reason) {
                        MainCubit.get(context).changeIndicator(index);
                      },
                      viewportFraction: 1.0,
                      height: 230,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                        appBannerList.length,
                        (index) => Indicator(
                            isActive:
                                MainCubit.get(context).currentIndicator == index
                                    ? true
                                    : false))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //////////////////////////////////////////////
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        offset: Offset(1, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/Services.png")),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Services',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.5),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffffa726),
                          ),
                          // ignore: deprecated_member_use
                          child: MaterialButton(
                            padding: const EdgeInsets.all(15),
                            onPressed: () {
                              navigateTo(context, Emergency_Numbers());
                            },
                            child: const Text("Learn More",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
