import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSources {
  Future<String> signUpWithPhone({
    required String phoneNumber,
  });

  Future<String> signInWithPhone({
    required String phoneNumber,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSources {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});
  @override
  Future<String> signInWithPhone({required String phoneNumber}) async {
    // TODO: implement signInWithPhone
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithPhone({required String phoneNumber}) async {
    // TODO: implement signUpWithPhone
    await supabaseClient.auth.signInWithOtp(phone: phoneNumber);
    throw UnimplementedError();
  }
}
