import 'package:flutter/material.dart';

class TextFieldWidget extends FormField<String> {
  TextFieldWidget(
      {required FormFieldValidator<String> validator,
      required FormFieldSetter<String> onSaved,
      String defaultValue = '',
      String label = ''})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: defaultValue,
            builder: (FormFieldState<String> state) {
              return TextFormField(
                  validator: validator,
                  onSaved: onSaved,
                  keyboardType: TextInputType.text,
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
                  ));
            });
}
