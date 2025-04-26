import 'package:equatable/equatable.dart';
import '../../domain/entities/bundle.dart';

abstract class MarketplaceState extends Equatable {
  const MarketplaceState();

  @override
  List<Object?> get props => [];
}

class MarketplaceInitial extends MarketplaceState {}

class MarketplaceLoading extends MarketplaceState {}

class MarketplaceLoaded extends MarketplaceState {
  final List<Bundle> bundles;

  const MarketplaceLoaded(this.bundles);

  @override
  List<Object?> get props => [bundles];
}

class MarketplaceError extends MarketplaceState {
  final String message;

  const MarketplaceError(this.message);

  @override
  List<Object?> get props => [message];
}

class BundleDetailsLoading extends MarketplaceState {}

class BundleDetailsLoaded extends MarketplaceState {
  final Bundle bundle;

  const BundleDetailsLoaded(this.bundle);

  @override
  List<Object?> get props => [bundle];
}

class BundlePurchaseLoading extends MarketplaceState {}

class BundlePurchaseSuccess extends MarketplaceState {
  final dynamic purchaseDetails;

  const BundlePurchaseSuccess(this.purchaseDetails);

  @override
  List<Object?> get props => [purchaseDetails];
}

class BundlePurchaseError extends MarketplaceState {
  final String message;

  const BundlePurchaseError(this.message);

  @override
  List<Object?> get props => [message];
}