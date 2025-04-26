import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/features/reseller/marketplace/presentation/blocs/marketplace_event.dart';
import 'package:mobile_frontend/features/reseller/marketplace/presentation/blocs/marketplace_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_available_bundles.dart';
import '../../domain/usecases/get_bundle_details.dart';
import '../../domain/usecases/purchase_bundle.dart';
import '../../domain/usecases/search_bundles_by_title.dart';


class MarketplaceBloc extends Bloc<MarketplaceEvent, MarketplaceState> {
  final GetAvailableBundles getAvailableBundles;
  final GetBundleDetails getBundleDetails;
  final SearchBundlesByTitle searchBundles;
  final PurchaseBundle purchaseBundle;

  MarketplaceBloc({
    required this.getAvailableBundles,
    required this.getBundleDetails,
    required this.searchBundles,
    required this.purchaseBundle,
  }) : super(MarketplaceInitial()) {
    on<LoadBundles>(_loadBundles);
    on<LoadBundleDetails>(_loadBundleDetails);
    on<SearchBundlesEvent>(_searchBundles);
    on<PurchaseBundleEvent>(_purchaseBundle);
  }

  Future<void> _loadBundles(LoadBundles event, Emitter<MarketplaceState> emit) async {
    emit(MarketplaceLoading());
    
    final result = await getAvailableBundles(NoParams());
    
    result.fold(
      (failure) => emit(MarketplaceError(failure.toString())),
      (bundles) => emit(MarketplaceLoaded(bundles)),
    );
  }

  Future<void> _loadBundleDetails(LoadBundleDetails event, Emitter<MarketplaceState> emit) async {
    emit(BundleDetailsLoading());
    
    final result = await getBundleDetails(event.bundleId);
    
    result.fold(
      (failure) => emit(MarketplaceError(failure.toString())),
      (bundle) => emit(BundleDetailsLoaded(bundle)),
    );
  }

  Future<void> _searchBundles(SearchBundlesEvent event, Emitter<MarketplaceState> emit) async {
    emit(MarketplaceLoading());
    
    final result = await searchBundles(event.searchQuery);
    
    result.fold(
      (failure) => emit(MarketplaceError(failure.toString())),
      (bundles) => emit(MarketplaceLoaded(bundles)),
    );
  }

  Future<void> _purchaseBundle(PurchaseBundleEvent event, Emitter<MarketplaceState> emit) async {
    emit(BundlePurchaseLoading());
    
    final result = await purchaseBundle(event.bundleId);
    
    result.fold(
      (failure) => emit(BundlePurchaseError(failure.toString())),
      (purchaseDetails) => emit(BundlePurchaseSuccess(purchaseDetails)),
    );
  }
}