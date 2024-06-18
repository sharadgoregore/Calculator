import 'dart:convert';

class ConfigModel {
  RateOfInterest rateOfInterest;
  PrincipalAmount principalAmount;
  CompoundingFrequency compoundingFrequency;
  NoOfYears noOfYears;
  OutputValue outputValue;

  ConfigModel({
    required this.rateOfInterest,
    required this.principalAmount,
    required this.compoundingFrequency,
    required this.noOfYears,
    required this.outputValue,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      rateOfInterest: RateOfInterest.fromJson(json['rateOfInterest']),
      principalAmount: PrincipalAmount.fromJson(json['principalAmount']),
      compoundingFrequency:
          CompoundingFrequency.fromJson(json['compoundingFrequency']),
      noOfYears: NoOfYears.fromJson(json['noOfYears']),
      outputValue: OutputValue.fromJson(json['outputValue']),
    );
  }
}

class RateOfInterest {
  String textColor;
  double textSize;
  String labelText;
  Map<String, int> values;

  RateOfInterest({
    required this.textColor,
    required this.textSize,
    required this.labelText,
    required this.values,
  });

  factory RateOfInterest.fromJson(Map<String, dynamic> json) {
    return RateOfInterest(
      textColor: json['textColor'],
      textSize: json['textSize'],
      labelText: json['labelText'],
      values: Map<String, int>.from(json['values']),
    );
  }
}

class PrincipalAmount {
  String hintText;
  String labelText;
  String textColor;
  double textSize;
  Map<String, int> minAmount;
  int maxAmount;
  Map<String, String> errorMessage;

  PrincipalAmount({
    required this.hintText,
    required this.labelText,
    required this.textColor,
    required this.textSize,
    required this.minAmount,
    required this.maxAmount,
    required this.errorMessage,
  });

  factory PrincipalAmount.fromJson(Map<String, dynamic> json) {
    return PrincipalAmount(
      labelText: json['labelText'],
      hintText: json['hintText'],
      textColor: json['textColor'],
      textSize: json['textSize'],
      minAmount: Map<String, int>.from(json['minAmount']),
      maxAmount: json['maxAmount'],
      errorMessage: Map<String, String>.from(json['errorMessage']),
    );
  }
}

class CompoundingFrequency {
  String labelText;
  String textColor;
  double textSize;
  Map<String, int> values;

  CompoundingFrequency({
    required this.labelText,
    required this.textColor,
    required this.textSize,
    required this.values,
  });

  factory CompoundingFrequency.fromJson(Map<String, dynamic> json) {
    return CompoundingFrequency(
      labelText: json['labelText'],
      textColor: json['textColor'],
      textSize: json['textSize'],
      values: Map<String, int>.from(json['values']),
    );
  }
}

class NoOfYears {
  String labelText;
  String textColor;
  double textSize;
  Map<String, List<int>> values;

  NoOfYears({
    required this.labelText,
    required this.textColor,
    required this.textSize,
    required this.values,
  });

  factory NoOfYears.fromJson(Map<String, dynamic> json) {
    Map<String, List<int>> values = {};
    json['values'].forEach((key, value) {
      values[key] = List<int>.from(value);
    });

    return NoOfYears(
      labelText: json['labelText'],
      textColor: json['textColor'],
      textSize: json['textSize'],
      values: values,
    );
  }
}

class OutputValue {
  String textColor;
  String labelText;
  double textSize;
  String modeOfDisplay;

  OutputValue({
    required this.textColor,
    required this.labelText,
    required this.textSize,
    required this.modeOfDisplay,
  });

  factory OutputValue.fromJson(Map<String, dynamic> json) {
    return OutputValue(
      textColor: json['textColor'],
      labelText: json['labelText'],
      textSize: json['textSize'],
      modeOfDisplay: json['modeOfDisplay'],
    );
  }
}
