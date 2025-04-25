import 'package:equatable/equatable.dart';

abstract class MarketplaceEvent extends Equatable {
  const MarketplaceEvent();

  @override
  List<Object?> get props => [];
}

class LoadBundles extends MarketplaceEvent {
  @override
  List<Object?> get props => [];
}

class LoadBundleDetails extends MarketplaceEvent {
  final String bundleId;

  const LoadBundleDetails({required this.bundleId});

  @override
  List<Object?> get props => [bundleId];
}

class SearchBundlesEvent extends MarketplaceEvent {
  final String searchQuery;

  const SearchBundlesEvent({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

class PurchaseBundleEvent extends MarketplaceEvent {
  final String bundleId;

  const PurchaseBundleEvent({required this.bundleId});

  @override
  List<Object?> get props => [bundleId];
}