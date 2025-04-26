import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_frontend/features/reseller/dashboard/domain/entities/dashboard_metrics.dart';
import 'package:mobile_frontend/features/reseller/unpack/domain/entities/unpack_bundle.dart';
import '../bloc/unpack_bloc.dart';
import '../bloc/unpack_event.dart';
import '../bloc/unpack_state.dart';

class UnpackBundlePage extends StatefulWidget {
  final BoughtBundle bundle;
  final int remainingItems;

  const UnpackBundlePage({
    super.key,
    required this.bundle,
    required this.remainingItems,
  });

  @override
  State<UnpackBundlePage> createState() => _UnpackBundlePageState();
}

class _UnpackBundlePageState extends State<UnpackBundlePage> {
  final _formKey = GlobalKey<FormState>();
  final _clothNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;
  String? _selectedStatus;
  XFile? _imageFile;
  bool _isLoading = false;

  final List<String> _categories = [
    'Shirts',
    'Pants',
    'Dresses',
    'Accessories'
  ];
  final List<String> _statuses = ['Type A', 'Type B', 'Type C'];

  @override
  void dispose() {
    _clothNameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  void _submitForm() {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      // Show confirmation dialog before submitting
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Unpacking'),
            content: const Text('Are you sure you want to unpack this item?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  final unpackItem = UnpackBundle(
                    clothName: _clothNameController.text,
                    category: _selectedCategory!,
                    status: _selectedStatus!,
                    price: double.parse(_priceController.text),
                    description: _descriptionController.text,
                    imageUrl: kIsWeb 
                      ? _imageFile!.path
                      : base64Encode(File(_imageFile!.path).readAsBytesSync()),
                    bundleId: widget.bundle.id,
                  );
                  context.read<UnpackBloc>().add(UnpackBundleItemEvent(unpackItem));
                },
                child: const Text('Confirm'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UnpackBloc, UnpackState>(
        listener: (context, state) {
          if (state is UnpackLoading) {
            setState(() => _isLoading = true);
          } else if (state is UnpackSuccess) {
            setState(() => _isLoading = false);
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Item successfully unpacked!')),
            );
            // Update the remaining items count
            final updatedRemainingItems = widget.remainingItems - 1;
            // Navigate back with the updated count
            Navigator.pop(context);
            Navigator.pop(context, updatedRemainingItems);
          } else if (state is UnpackError) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Header(),
                  const SizedBox(height: 25),
                  _buildBundleHeader(),
                  const SizedBox(height: 20),
                  _buildImageUpload(),
                  const SizedBox(height: 20),
                  _buildFormFields(),
                  const SizedBox(height: 30),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBundleHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.bundle.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                widget.bundle.status,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text('${widget.remainingItems} items • left',
            style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildImageUpload() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 212,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD5D5D5), width: 1),
        ),
        child: _imageFile != null
            ? kIsWeb
                ? Image.network(_imageFile!.path, fit: BoxFit.cover)
                : Image.network(_imageFile!.path, fit: BoxFit.cover)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.cloud_upload_outlined, size: 24),
                  SizedBox(height: 10),
                  Text(
                    'Click or drag image to this area to upload',
                    style: TextStyle(fontSize: 16, color: Color(0xFF484848)),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          label: 'Cloth Name',
          controller: _clothNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a cloth name';
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        _buildDropdownField(
          label: 'Category',
          value: _selectedCategory,
          items: _categories,
          onChanged: (value) {
            setState(() => _selectedCategory = value);
          },
        ),
        const SizedBox(height: 15),
        _buildDropdownField(
          label: 'Status',
          value: _selectedStatus,
          items: _statuses,
          onChanged: (value) {
            setState(() => _selectedStatus = value);
          },
        ),
        const SizedBox(height: 15),
        _buildTextField(
          label: 'Price (USD)',
          controller: _priceController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a price';
            }
            if (double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        _buildTextField(
          label: 'Description',
          controller: _descriptionController,
          maxLines: null,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a description';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Color(0xFF666666)),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD5D5D5), width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD5D5D5), width: 1),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Color(0xFF666666)),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD5D5D5)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            items: items.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an option';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              side: const BorderSide(color: Color(0xFFCBCBCB)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : _submitForm,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: const Color(0xFF008080),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Post to Marketplace',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
          ),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.menu, size: 24),
          onPressed: () {
            // Handle menu button press
          },
        ),
        const Center(
          child: Text(
            'Unpack Bundles',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications, size: 30),
                  onPressed: () {
                    // Handle notification button press
                  },
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: Container(
                    height: 19,
                    width: 19,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC53030),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
                  ),
                  radius: 24,
                ),
                Positioned(
                  bottom: 2,
                  right: 4,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF54D62C),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}