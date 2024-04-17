import 'package:dartz/dartz.dart';
import 'package:veridox/core/errors/failures.dart';

abstract class AuthRepositoryInterface {
  Future<Either<Failure, String>> signUpWithPhone({
    required String phoneNumber,
  });

  Future<Either<Failure, String>> signInWithPhone({
    required String phoneNumber,
  });
}
