import 'package:flutter/material.dart';

class DateFieldWidget extends FormField<String> {
  DateFieldWidget(
      {required FormFieldValidator<String> validator,
        required FormFieldSetter<String> onSaved,
        int? defaultValue,
        String label = ''})
      : super(
      onSaved: onSaved,
      validator: validator,
      initialValue: defaultValue?.toString(),
      builder: (FormFieldState<String> state) {
        return InputDatePickerFormField(firstDate: DateTime.now(), lastDate: null,
          
        );
      });
}