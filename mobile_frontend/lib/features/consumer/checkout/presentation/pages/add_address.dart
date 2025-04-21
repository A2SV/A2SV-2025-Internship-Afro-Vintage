import 'package:flutter/material.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/button.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/input.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _phonenumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text;
      final country = _countryController.text;
      final city = _cityController.text;
      final phoneNumber = _phonenumberController.text;
      final address = _addressController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$name $country $city $phoneNumber $address')),
      );

      _nameController.clear();
      _countryController.clear();
      _cityController.clear();
      _phonenumberController.clear();
      _addressController.clear();

      Navigator.pushNamed(context, '/checkout');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Add Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 45,
                ),
                CustomTextField(
                  label: 'Name',
                  controller: _nameController,
                  fieldKey: const Key('nameField'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: 'Country',
                  controller: _countryController,
                  fieldKey: const Key('countryField'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your country';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: 'City',
                  controller: _cityController,
                  fieldKey: const Key('cityField'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: 'Phone Number',
                  controller: _phonenumberController,
                  fieldKey: const Key('phoneNumberField'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your  phone number';
                    }
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Phone number must contain only digits';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  label: 'Address',
                  controller: _addressController,
                  fieldKey: const Key('addressField'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  label: "Save Address",
                  onPressed: _submitForm,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        onCartTap: () {},
      ),
    );
  }
}
