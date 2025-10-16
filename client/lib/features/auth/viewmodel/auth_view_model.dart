import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  @override
  AsyncValue<UserModel> build() {
    _authRemoteRepository=ref.watch();
    return const AsyncValue.loading();
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    state = AsyncLoading();
    final res = await _authRemoteRepository.signup(
      name: name,
      email: email,
      password: password,
    );

    final val = switch (res) {
      Left(value: final l) => state = AsyncError(l.message, StackTrace.current),
      Right(value: final r) => state=AsyncValue.data(r),
    };

    print(val);
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = AsyncLoading();
    final res = await _authRemoteRepository.login(
      email: email,
      password: password,
    );

    final val = switch (res) {
      Left(value: final l) => state = AsyncError(l.message, StackTrace.current),
      Right(value: final r) => state=AsyncValue.data(r),
    };

    print(val);
  }
}
