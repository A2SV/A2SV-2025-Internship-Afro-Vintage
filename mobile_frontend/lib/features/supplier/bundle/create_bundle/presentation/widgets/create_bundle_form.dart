import 'dart:io';

import 'package:flutter/material.dart';
import '../bundle_request_model.dart';
import '../repository/bundle_repository.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/input.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/button.dart';

class CreateBundleForm extends StatefulWidget {
  final BundleRepository repository;
  const CreateBundleForm({Key? key, required this.repository})
      : super(key: key);

  @override
  State<CreateBundleForm> createState() => _CreateBundleFormState();
}

class _CreateBundleFormState extends State<CreateBundleForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _imageController = TextEditingController();
  final _numberOfItemsController = TextEditingController();
  final _gradeController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _typeController = TextEditingController(text: 'sorted');
  final _declaredRatingController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _titleController.dispose();
    _imageController.dispose();
    _numberOfItemsController.dispose();
    _gradeController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _typeController.dispose();
    _declaredRatingController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final bundle = {
        'title': _titleController.text.isEmpty ? null : _titleController.text,
        'sample_image':
            _imageController.text.isEmpty ? null : _imageController.text,
        'number_of_items': _numberOfItemsController.text.isEmpty
            ? null
            : int.parse(_numberOfItemsController.text),
        'grade': _gradeController.text.isEmpty ? 'A' : _gradeController.text,
        'price': _priceController.text.isEmpty
            ? null
            : double.parse(_priceController.text),
        'description': _descriptionController.text.isEmpty
            ? null
            : _descriptionController.text,
        'size_range':
            'S-XL', // You may want to make this a field in the form if needed
        'clothing_types': [
          'T-Shirt',
          'Jeans'
        ], // You may want to make this a field in the form if needed
        'type': _typeController.text.isEmpty ? null : _typeController.text,
        'estimated_breakdown': {
          'T-Shirt': 4,
          'Jeans': 6
        }, // You may want to make this a field in the form if needed
        'declared_rating': _declaredRatingController.text.isEmpty
            ? null
            : int.parse(_declaredRatingController.text),
      };
      print('[DEBUG] Bundle request body:');
      print(bundle);
      await widget.repository.api.post('/bundles', body: bundle);
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/mywarehouse');
      }
    } catch (e) {
      print('[DEBUG] Error creating bundle: $e');
      setState(() {
        _error = 'Failed to create bundle: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 45),
            CustomTextField(
              label: 'Title',
              controller: _titleController,
              fieldKey: const Key('titleField'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            CustomTextField(
              label: 'Sample Image URL',
              controller: _imageController,
              fieldKey: const Key('imageField'),
            ),
            CustomTextField(
              label: 'Number of Items',
              controller: _numberOfItemsController,
              isNumeric: true,
              fieldKey: const Key('numberOfItemsField'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            DropdownButtonFormField<String>(
              value:
                  _gradeController.text.isEmpty ? 'A' : _gradeController.text,
              decoration: const InputDecoration(
                labelText: 'Grade',
                border: OutlineInputBorder(),
              ),
              items: ['A', 'B', 'C', 'D'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _gradeController.text = newValue ?? 'A';
                });
              },
            ),
            CustomTextField(
              label: 'Price',
              controller: _priceController,
              isNumeric: true,
              fieldKey: const Key('priceField'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            CustomTextField(
              label: 'Description',
              controller: _descriptionController,
              fieldKey: const Key('descriptionField'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            DropdownButtonFormField<String>(
              value: _typeController.text,
              decoration: const InputDecoration(
                labelText: 'Sorting Level',
                border: OutlineInputBorder(),
              ),
              items: ['sorted', 'semi_sorted', 'unsorted'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _typeController.text = newValue ?? 'sorted';
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a sorting level';
                }
                return null;
              },
            ),
            CustomTextField(
              label: 'Declared Rating',
              controller: _declaredRatingController,
              isNumeric: true,
              fieldKey: const Key('declaredRatingField'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 20),
            if (_error != null) ...[
              Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 8),
            ],
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: UnColoredButton(
                      label: 'Cancel',
                      onPressed: () {
                        if (!_loading) Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                      height: 48,
                      child: SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor,
                            ),
                            onPressed: _loading ? () {} : () => _submit(),
                            child: const Text(
                              'Create Bundle',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            )),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
