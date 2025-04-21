import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const PrimaryButton(
      {super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}

class ColoredButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const ColoredButton(
      {super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return SizedBox(
      width: 120,
      height: 40,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          )),
    );
  }
}

class UnColoredButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const UnColoredButton(
      {super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 40,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.black.withOpacity(0.2), width: 2),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
            ),
          )),
    );
  }
}
