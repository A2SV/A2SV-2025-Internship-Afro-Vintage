import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextSection extends StatefulWidget {
  const TextSection({super.key});
  @override
  State<TextSection> createState() => _TextSectionState();
}

class _TextSectionState extends State<TextSection> {
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome back!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 1),
        Text(
          'Hi, ${_username ?? ''}',
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.normal,
            color: Color(0xFF969393),
          ),
        ),
      ],
    );
  }
}
