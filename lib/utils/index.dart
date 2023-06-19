import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PlusMinusRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return const TextEditingValue();
    }
    if (int.parse(newValue.text) < 0) {
      return const TextEditingValue().copyWith(text: '');
    }

    return int.parse(newValue.text) > 15
        ? const TextEditingValue().copyWith(text: '15')
        : newValue;
  }
}

void showToastError(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showToastSuccess(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
