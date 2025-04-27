import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_frontend/features/auth/domain/entities/user.dart';
import 'package:mobile_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_frontend/features/auth/presentation/bloc/auth_event.dart';
import 'package:mobile_frontend/features/auth/presentation/bloc/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoleSelectionPage extends StatefulWidget {
  final String username;
  final String email;
  final String password;

  const RoleSelectionPage({
    super.key,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  String? _selectedRole;
  bool _isLoading = false; // Track loading state

  void _submitRole() {
    if (_selectedRole != null) {
      setState(() {
        _isLoading = true; // Set loading state to true
      });

      final user = User(
        username: widget.username,
        email: widget.email,
        password: widget.password,
        role: _selectedRole!,
      );

      context.read<AuthBloc>().add(SignupEvent(user: user));
    } else {
      // Show error if no role is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).primaryColor;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is Success) {
          setState(() {
            _isLoading = false; // Stop loading when success is reached
          });

          final selectedRole = state.data.user!.role;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', state.data.token);
          await prefs.setString(
              'role', selectedRole!); // Save the role to local storage

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Success: ${state.data.user!.username}')),
          );

          // Navigate to the appropriate page based on the role
          if (selectedRole == 'supplier') {
            Navigator.pushNamed(context, '/consumermarketplace');
          } else if (selectedRole == 'reseller') {
            Navigator.pushNamed(context, '/supplier-reseller-marketplace');
          } else if (selectedRole == 'consumer') {
            Navigator.pushNamed(context, '/consumermarketplace');
          }
        } else if (state is Error) {
          setState(() {
            _isLoading = false; // Stop loading on error
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/landing_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 380,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/logo/AfroVintageLogo.svg',
                        width: 200,
                        height: 100,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Join as a Supplier or Reseller or Consumer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(),
                        ),
                        child: RadioListTile<String>(
                          title: const Text(
                            "I'm a Supplier",
                            style: TextStyle(color: Colors.black87),
                          ),
                          value: 'supplier',
                          groupValue: _selectedRole,
                          activeColor: primary,
                          onChanged: (value) {
                            setState(() {
                              _selectedRole = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(),
                        ),
                        child: RadioListTile<String>(
                          title: const Text(
                            "I'm a Reseller",
                            style: TextStyle(color: Colors.black87),
                          ),
                          value: 'reseller',
                          groupValue: _selectedRole,
                          activeColor: primary,
                          onChanged: (value) {
                            setState(() {
                              _selectedRole = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(),
                        ),
                        child: RadioListTile<String>(
                          title: const Text(
                            "I'm a Consumer",
                            style: TextStyle(color: Colors.black87),
                          ),
                          value: 'consumer',
                          groupValue: _selectedRole,
                          activeColor: primary,
                          onChanged: (value) {
                            setState(() {
                              _selectedRole = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _isLoading
                            ? null
                            : _submitRole, // Disable button when loading
                        child: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
