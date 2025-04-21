import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isNumeric;
  final int maxLines;
  final String? Function(String?)? validator;
  final Key fieldKey;

  const CustomTextField({
    required this.label,
    required this.controller,
    this.isNumeric = false,
    this.maxLines = 1,
    this.validator,
    required this.fieldKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(height: 5),
        TextFormField(
          key: fieldKey,
          controller: controller,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          style: const TextStyle(),
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
