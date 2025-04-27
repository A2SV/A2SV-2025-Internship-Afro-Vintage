part of 'create_bundle_bloc.dart';

abstract class CreateBundleEvent extends Equatable {
  const CreateBundleEvent();
}

class CreateBundleSubmitted extends CreateBundleEvent {
  final String name;
  final int itemCount;
  final String type;
  final double price;
  final String description;
  final List<String> imageUrls;
  final String grade;
  final int declaredRating;

  const CreateBundleSubmitted({
    required this.name,
    required this.itemCount,
    required this.type,
    required this.price,
    required this.description,
    required this.imageUrls,
    required this.grade,
    required this.declaredRating,
  });

  @override
  List<Object> get props => [name, itemCount, type, price, description, imageUrls, grade, declaredRating];
}