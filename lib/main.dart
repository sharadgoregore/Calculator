import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Binding/HomeBinding.dart';
import '../../View/Homepage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      home: HomeScreen(),
    );
  }
}
