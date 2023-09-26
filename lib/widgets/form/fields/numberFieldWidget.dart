import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberFieldWidget extends FormField<int> {
  NumberFieldWidget(
      {required FormFieldValidator<int> validator,
      required FormFieldSetter<int> onSaved,
      int defaultValue = -1,
      String label = ''})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: defaultValue,
            builder: (FormFieldState<int> state) {
              return TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: label,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
              );
            });
}
