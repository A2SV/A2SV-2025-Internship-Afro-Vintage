import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/auth/data/datasources/auth_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile_frontend/features/auth/domain/entities/user.dart'; // Ensure this is the correct path
import 'package:mobile_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_frontend/features/auth/domain/usecases/signin.dart';
import 'signin_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SigninUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SigninUseCase(repository: mockAuthRepository);
  });

  final tUser = LoginUser(
    username: 'test',
    password: 'password123',
  );

  final tUserResponse = UserResponse(
    id: 'test_id',
    username: 'testuser',
    role: 'consumer',
  );

  final tAuthResponse = AuthResponse(
    token: 'test_token',
    user: tUserResponse,
  );

  test(
    'should sign in a user and return AuthResponse',
    () async {
      // Arrange
      when(mockAuthRepository.signin(any))
          .thenAnswer((_) async => Right(tAuthResponse));

      // Act
      final result = await usecase(SigninParams(user: tUser));

      // Assert
      expect(result, Right(tAuthResponse));
      verify(mockAuthRepository.signin(tUser));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'should return a Failure when signin fails',
    () async {
      // Arrange
      when(mockAuthRepository.signin(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // Act
      final result = await usecase(SigninParams(user: tUser));

      // Assert
      expect(result, Left(ServerFailure()));
      verify(mockAuthRepository.signin(tUser));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
