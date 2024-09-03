import 'dart:math';
import 'dart:core';

void main() {
  var rounding = Rounding();
  print(rounding.getFinalResult(87.2, 3));
}

class Rounding {
  String getFinalResult(double value, double inaccuracy) {
    int inaccuracyPow, valuePow;
    (inaccuracy, inaccuracyPow) = makeLooksGood(inaccuracy);
    inaccuracy = roundUpInaccuracy(inaccuracy);

    (value, valuePow) = makeLooksGood(value);

    int scale = inaccuracyPow < 0
        ? ((inaccuracy * pow(10, inaccuracyPow))
            .toStringAsFixed(
                (inaccuracy * pow(10, inaccuracyPow)).toString().length)
            .split('.')[1]
            .length)
        : (inaccuracy).toString().split('.')[1].length;

    value = roundUpValue(value, scale);

    return '${(value)} ± ${(inaccuracy)}';
  }

  ///0.00021 -> 0.21 -3
  ///512.34 -> 0.51234 3
  ///0.42 -> 0
  (double, int) makeLooksGood(double value) {
    int pow_ = 0;
    String string_value = value.toString();
    if (value >= 1) {
      pow_ = string_value.split('.')[0].length;
      string_value = '0.' + string_value.replaceAll('.', '');
      return (double.parse(string_value), pow_);
    } else if (string_value[2] != '0') {
      return (value, pow_);
    }
    String working_string = string_value.split('.')[1];
    pow_ += 1;
    for (int i = 0; i < working_string.length - 1; i++) {
      if (working_string[i + 1] == '0') {
        pow_++;
      }
    }
    working_string = '0.' + working_string.substring(pow_);
    return (double.parse(working_string), -pow_);
  }

  double roundUpInaccuracy(double value) {
    String working_value = value.toStringAsFixed(2).split('.')[1];
    print(working_value);
    if (int.parse(working_value[0]) <= 2) {
      return double.parse(value.toStringAsFixed(2));
    } else if (working_value[1] == '5') {
      if (int.parse(working_value[0]) % 2 != 0) {
        return double.parse('0.' + '${int.parse(working_value[0]) + 1}');
      }
    }

    return double.parse('0.' + working_value[0]);
  }

  double roundUpValue(double value, int scale) {
    return double.parse(value.toStringAsFixed(scale));
  }
}
