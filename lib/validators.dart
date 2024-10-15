import 'package:flutter/widgets.dart';


class Validators {
  static FormFieldValidator<String> required(String errorMessage) {
    return (value) {
      if (value!.isEmpty) {
        return errorMessage;
      } else {
        return null;
      }
    };
  }


  static FormFieldValidator<String> min(double min, String errorMessage) {
    return (value) {
      if (value!.startsWith('.') ||
          value!.startsWith('-') ||
          value!.endsWith('-') ||
          value!.endsWith('.') ||
          value!.contains('-')) {
        return 'Invalid numeric pattern!';
      }
      if (value.trim().isEmpty) {
        return null;
      }
      final dValue = double.parse(value);
      if (dValue < min) {
        return errorMessage;
      }
      return null;
    };
  }


  static FormFieldValidator<String> compose(List<FormFieldValidator<String>> validators) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}



