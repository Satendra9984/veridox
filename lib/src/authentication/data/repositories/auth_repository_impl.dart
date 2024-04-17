import 'package:dartz/dartz.dart';
import 'package:veridox/core/errors/failures.dart';
import 'package:veridox/src/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:veridox/src/authentication/domain/repository/auth_repository_interface.dart';

class AuthRepositoryImpl implements AuthRepositoryInterface {
  final AuthRemoteDataSources authRemoteDataSources;

  AuthRepositoryImpl({required this.authRemoteDataSources});

  @override
  Future<Either<Failure, String>> signInWithPhone(
      {required String phoneNumber}) {
    // TODO: implement signInWithPhone
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithPhone(
      {required String phoneNumber}) {
    // TODO: implement signUpWithPhone
    throw UnimplementedError();
  }
}
