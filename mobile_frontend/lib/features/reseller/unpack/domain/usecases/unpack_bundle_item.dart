import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/reseller/unpack/domain/repository/unpack_repository.dart';
import '../entities/unpack_bundle.dart';

class UnpackBundleItem {
  final UnpackRepository repository;

  UnpackBundleItem(this.repository);

  Future<Either<Failure, void>> call(UnpackBundle item) async {
    return await repository.unpackBundleItem(item);
  }
}