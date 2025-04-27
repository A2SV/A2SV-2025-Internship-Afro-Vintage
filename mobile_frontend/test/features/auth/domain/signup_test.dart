import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_frontend/features/auth/data/datasources/auth_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile_frontend/core/error/failure.dart';
import 'package:mobile_frontend/features/auth/domain/entities/user.dart';
import 'package:mobile_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_frontend/features/auth/domain/usecases/signup.dart';

import 'signup_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignupUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignupUseCase(repository: mockAuthRepository);
  });

  final tUser = User(
    username: 'testuser',
    email: 'test@example.com',
    password: 'password123',
    role: 'consumer',
  );

  final tUserResponse = UserResponse(
    id: 'test_id', // Add the required 'id' parameter
    username: tUser.username,
    role: tUser.role,
  );

  final tAuthResponse = AuthResponse(
    token: 'test_token',
    user: tUserResponse,
  );

  test(
    'should sign up a user and return AuthResponse',
    () async {
      // Arrange
      when(mockAuthRepository.signup(any))
          .thenAnswer((_) async => Right(tAuthResponse));

      // Act
      final result = await usecase(SignupParams(user: tUser));

      // Assert
      expect(result, Right(tAuthResponse));
      verify(mockAuthRepository.signup(tUser));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'should return a Failure when signup fails',
    () async {
      // Arrange
      when(mockAuthRepository.signup(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // Act
      final result = await usecase(SignupParams(user: tUser));

      // Assert
      expect(result, Left(ServerFailure()));
      verify(mockAuthRepository.signup(tUser));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
