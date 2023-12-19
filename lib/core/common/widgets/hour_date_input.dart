import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HourDateInput extends StatelessWidget {
  const HourDateInput({super.key, required this.controller, required this.hintText, required this.keyboardType});

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;



  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$'),
        ),
      ],
      decoration: InputDecoration(
        labelText: '00:00',
        hintText: hintText,
      ),
    );
  }
}