import 'dart:io';
import 'package:flutter/material.dart';
import '../../../create_bundle/presentation/bundle_request_model.dart';
import '../../../create_bundle/presentation/repository/bundle_repository.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/input.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/button.dart';

class EditBundleForm extends StatefulWidget {
  final BundleRepository repository;
  final String bundleId;
  const EditBundleForm({Key? key, required this.repository, required this.bundleId}) : super(key: key);

  @override
  State<EditBundleForm> createState() => _EditBundleFormState();
}

class _EditBundleFormState extends State<EditBundleForm> {
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
  String? _selectedGrade;

  @override
  void initState() {
    super.initState();
    _fetchAndFillBundle();
  }

  Future<void> _fetchAndFillBundle() async {
    setState(() { _loading = true; _error = null; });
    try {
      print('[DEBUG] Fetching bundle with ID: ${widget.bundleId}');
      final bundle = await widget.repository.fetchBundleById(widget.bundleId);
      print('[DEBUG] Fetched bundle data:');
      print('[DEBUG] Title: ${bundle.title}');
      print('[DEBUG] Description: ${bundle.description}');
      print('[DEBUG] Quantity: ${bundle.quantity}');
      print('[DEBUG] Grade: ${bundle.grade}');
      print('[DEBUG] Rating: ${bundle.declaredRating}');
      
      if (mounted) {
        setState(() {
          _titleController.text = bundle.title;
          _imageController.text = bundle.sampleImage;
          _numberOfItemsController.text = bundle.quantity.toString();
          _selectedGrade = bundle.grade;
          _gradeController.text = bundle.grade;
          _priceController.text = bundle.price.toString();
          _typeController.text = bundle.type;
          _descriptionController.text = bundle.description;
          _declaredRatingController.text = bundle.declaredRating.toString();
          
          print('[DEBUG] Form values after setting:');
          print('[DEBUG] Title: ${_titleController.text}');
          print('[DEBUG] Description: ${_descriptionController.text}');
          print('[DEBUG] Quantity: ${_numberOfItemsController.text}');
          print('[DEBUG] Grade: ${_gradeController.text}');
          print('[DEBUG] Rating: ${_declaredRatingController.text}');
        });
      }
    } catch (e) {
      print('[DEBUG] Error fetching bundle: $e');
      if (mounted) {
        setState(() { 
          _error = 'Failed to fetch bundle details. Please try again later.';
          if (e.toString().contains('not found')) {
            _error = 'Bundle not found. It may have been deleted.';
          }
        });
      }
    } finally {
      if (mounted) {
        setState(() { _loading = false; });
      }
    }
  }

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
    setState(() { _loading = true; _error = null; });
    try {
      final bundle = BundleRequestModel(
        title: _titleController.text,
        sampleImage: _imageController.text,
        quantity: int.parse(_numberOfItemsController.text),
        grade: _selectedGrade ?? 'A',
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        type: _typeController.text,
        declaredRating: int.parse(_declaredRatingController.text),
      );

      await widget.repository.editBundle(
        id: widget.bundleId,
        bundle: bundle,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bundle updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() { 
        _error = 'Failed to update bundle. Please try again.';
        if (e.toString().contains('unauthorized')) {
          _error = 'You are not authorized to edit this bundle.';
        } else if (e.toString().contains('not found')) {
          _error = 'Bundle not found. It may have been deleted.';
        }
      });
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              validator: (v) => null,
            ),
            CustomTextField(
              label: 'Number of Items',
              controller: _numberOfItemsController,
              isNumeric: true,
              fieldKey: const Key('numberOfItemsField'),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                final number = int.tryParse(v);
                if (number == null) return 'Must be a number';
                if (number <= 0) return 'Must be greater than 0';
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              value: _selectedGrade,
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
                  _selectedGrade = newValue;
                  _gradeController.text = newValue ?? 'A';
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a grade';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Price',
              controller: _priceController,
              isNumeric: true,
              fieldKey: const Key('priceField'),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                final price = double.tryParse(v);
                if (price == null) return 'Must be a number';
                if (price < 0) return 'Must be 0 or greater';
                return null;
              },
            ),
            CustomTextField(
              label: 'Description',
              controller: _descriptionController,
              fieldKey: const Key('descriptionField'),
              maxLines: 3,
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
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                final rating = int.tryParse(v);
                if (rating == null) return 'Must be a number';
                if (rating < 1 || rating >= 100) return 'Must be between 1 and 100';
                return null;
              },
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
                    child: OutlinedButton(
                      onPressed: _loading ? null : () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF979797)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF6F3DE9),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _loading ? null : () => _submit(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        _loading ? 'Saving...' : 'Edit',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
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
