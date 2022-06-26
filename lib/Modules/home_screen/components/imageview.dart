import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBanner {
  final String url;
  AppBanner(this.url);
}

List<AppBanner> appBannerList = [
  AppBanner('assets/images/ad1.jpeg'),
  AppBanner('assets/images/ad2.jpeg'),
  AppBanner('assets/images/ad3.jpeg'),
  AppBanner('assets/images/ad4.jpeg'),
  AppBanner('assets/images/ad5.jpeg'),
  AppBanner('assets/images/ad6.jpeg'),
];

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 22.0 : 8,
      height: 8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? Color(0xffffa726) : Colors.grey),
    );
  }
}
