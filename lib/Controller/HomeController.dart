import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intrestcalculator/Model/Configmodel.dart';

class HomeController extends GetxController {
  late ConfigModel config;
  final RxInt rateOfInterest = 1.obs;
  final RxInt compoundingFrequency = 1.obs;
  final RxInt noOfYears = 1.obs;
  RxBool hasdata = false.obs;
  final TextEditingController textcontroller = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    loadConfig();
  }

// To load json data
  Future<void> loadConfig() async {
    final String response = await rootBundle.loadString('assets/jsondata.json');
    final data = await json.decode(response);
    var getdata = ConfigModel.fromJson(data);
    if (getdata != null) {
      hasdata(true);
      config = getdata;
    }
  }

// To get minimum principle Amount
  int getMinPrincipal(int rateOfInterest) {
    if (rateOfInterest >= 1 && rateOfInterest <= 3) {
      return config.principalAmount.minAmount['1-3']!;
    } else if (rateOfInterest >= 4 && rateOfInterest <= 7) {
      return config.principalAmount.minAmount['4-7']!;
    } else if (rateOfInterest >= 8 && rateOfInterest <= 12) {
      return config.principalAmount.minAmount['8-12']!;
    } else {
      return config.principalAmount.minAmount['13-15']!;
    }
  }

// To get Compounding value
  getCompoundingFrequency(int rateOfInterest) {
    if (rateOfInterest >= 7 && rateOfInterest <= 12) {
      return 1;
    } else if (rateOfInterest >= 4 && rateOfInterest <= 6) {
      return 2;
    } else if (rateOfInterest >= 1 && rateOfInterest <= 3) {
      return 4;
    } else {
      return [1, 2, 4];
    }
  }

// To calculate amount base on rate of intrest
  void calculateAndDisplayResult(controller, context) {
    final double P = double.parse(controller.text);
    final double r = rateOfInterest.value / 100.0;
    final int n = compoundingFrequency.value;
    final int t = noOfYears.value;

    final double A = P * pow((1 + r / n), n * t);

    String result = 'Final Amount: ${A.toStringAsFixed(2)}';

    switch (config.outputValue.modeOfDisplay) {
      case 'snack-bar message':
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result)));
        break;
      case 'pop-up dialog':
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(config.outputValue.labelText),
              content: Text(result),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );

        break;
    }
  }
}
