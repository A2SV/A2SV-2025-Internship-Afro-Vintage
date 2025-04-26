import 'package:dartz/dartz.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import '../entities/unpack_bundle.dart';

abstract class UnpackRepository {
  Future<Either<Failure, void>> unpackBundleItem(UnpackBundle item);
}