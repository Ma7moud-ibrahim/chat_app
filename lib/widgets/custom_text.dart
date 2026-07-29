import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({super.key, required this.label, this.onChanged});
  final String label;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'value is Empty.';
        }
        return null;
      },
      onChanged: onChanged,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: TextStyle(color: Colors.white, fontSize: 20),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}
