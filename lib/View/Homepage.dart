import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intrestcalculator/Controller/HomeController.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController principalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Compound Interest Calculator'),
      ),
      body: Obx(() => homeController.hasdata.value == true
          ? Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                          labelText:
                              homeController.config.rateOfInterest.labelText,
                          labelStyle: TextStyle(
                              color: Color(int.parse(homeController
                                  .config.rateOfInterest.textColor
                                  .replaceAll('#', '0xff'))),
                              fontSize: homeController
                                  .config.rateOfInterest.textSize),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        items: homeController
                            .config.rateOfInterest.values.entries
                            .map((entry) {
                          return DropdownMenuItem<int>(
                            value: entry.value,
                            child: Text(entry.key),
                          );
                        }).toList(),
                        onChanged: (value) {
                          homeController.rateOfInterest.value = value!;
                        },
                        value: homeController.rateOfInterest.value,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: principalController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText:
                              homeController.config.principalAmount.hintText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          labelText:
                              homeController.config.principalAmount.labelText,
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: homeController
                                  .config.principalAmount.textSize),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a principal amount';
                          }
                          final int principal = int.parse(value);
                          final int minPrincipal =
                              homeController.getMinPrincipal(
                                  homeController.rateOfInterest.value);
                          if (principal >
                              homeController.config.principalAmount.maxAmount) {
                            return homeController
                                .config.principalAmount.errorMessage['max'];
                          } else if (principal != minPrincipal) {
                            return homeController.config.principalAmount
                                .errorMessage['notequal'];
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          labelText: homeController
                              .config.compoundingFrequency.labelText,
                          labelStyle: TextStyle(
                              color: Color(int.parse(homeController
                                  .config.compoundingFrequency.textColor
                                  .replaceAll('#', '0xff'))),
                              fontSize: homeController
                                  .config.compoundingFrequency.textSize),
                        ),
                        items: homeController
                            .config.compoundingFrequency.values.entries
                            .map((entry) {
                          return DropdownMenuItem<int>(
                            value: entry.value,
                            child: Text(entry.value.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          homeController.compoundingFrequency.value = value!;
                        },
                        value: homeController.compoundingFrequency.value,
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        List<int> availableYears =
                            homeController.config.noOfYears.values[
                                homeController.compoundingFrequency.value
                                    .toString()]!;
                        return DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            labelText:
                                homeController.config.noOfYears.labelText,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelStyle: TextStyle(
                                color: Color(int.parse(homeController
                                    .config.noOfYears.textColor
                                    .replaceAll('#', '0xff'))),
                                fontSize:
                                    homeController.config.noOfYears.textSize),
                          ),
                          items: availableYears.map((year) {
                            return DropdownMenuItem<int>(
                              value: year,
                              child: Text(year.toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            homeController.noOfYears.value = value!;
                          },
                          value: homeController.noOfYears.value,
                        );
                      }),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            homeController.calculateAndDisplayResult(
                                principalController, context);
                          }
                        },
                        child: const Text('Calculate'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator())),
    );
  }
}
