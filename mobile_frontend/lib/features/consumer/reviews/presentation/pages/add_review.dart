import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/core/widgets/bottom_nav_bar.dart';
import 'package:mobile_frontend/core/widgets/common_app_bar.dart';
import 'package:mobile_frontend/core/widgets/side_menu.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/button.dart';
import 'package:mobile_frontend/features/consumer/core/widgets/input.dart';
import 'package:mobile_frontend/features/consumer/orders/domain/entities/order.dart';
import 'package:mobile_frontend/features/consumer/reviews/domain/entities/review.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/bloc/review_bloc.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/bloc/review_event.dart';
import 'package:mobile_frontend/features/consumer/reviews/presentation/bloc/review_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddReview extends StatefulWidget {
  final OrderEntity order; // Pass the order object if needed for the review

  const AddReview({super.key, required this.order});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  double _rating = 3.0;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('user_id'); // Assuming 'user_id' is the key
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User ID not found. Please log in.')),
        );
        return;
      }

      final review = Review(
        orderId: widget.order.id, // Assuming the order has an `id` field
        productId:
            widget.order.productIds[0], // Assuming the order has products
        userId: _userId!, // Use the user ID from local storage
        resellerId:
            widget.order.resellerId, // Assuming the order has a resellerId
        rating: _rating * 20, // Multiply the rating by 20 before sending
        comment: _descriptionController.text,
      );

      // Dispatch the AddReviewEvent to the Bloc
      context.read<ReviewBloc>().add(AddReviewEvent(review: review));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewBloc, ReviewState>(
      listener: (context, state) {
        if (state is ReviewLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Submitting review...')),
          );
        } else if (state is ReviewSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          Navigator.pop(context); // Navigate back after successful submission
        } else if (state is ReviewError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        drawer: const SideMenu(),
        appBar: const CommonAppBar(title: "Add Review"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    label: 'How was your experience?',
                    controller: _descriptionController,
                    maxLines: 5,
                    fieldKey: const Key('descriptionField'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rate your experience:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Slider(
                        value: _rating,
                        min: 1.0,
                        max: 5.0,
                        divisions: 4,
                        label: _rating.toString(),
                        onChanged: (value) {
                          setState(() {
                            _rating = value;
                          });
                        },
                      ),
                      Text(
                        'Rating: $_rating',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    label: "Submit Review",
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
      ),
    );
  }
}
