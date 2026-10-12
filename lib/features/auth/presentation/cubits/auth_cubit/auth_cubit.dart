import 'package:ecommerce_app_huma_volve/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthState.initial());
  final AuthRepo authRepo;
  //login btn cubit
  Future<void> onTapLoginBut({required String email, required String password}) async {
    emit(AuthState(action: AuthAction.login, status: AuthStatus.loading));

    final user = await authRepo.login(email: email, password: password);
    user.fold(
      (error) => emit(
        AuthState(
          action: AuthAction.login,
          status: AuthStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (_) => emit(AuthState(action: AuthAction.login, status: AuthStatus.success)),
    );
  }

  //SignUp cubit

Future<void> onTapSignUpBut({required UserModel userData}) async {
    emit(AuthState(action: AuthAction.signup, status: AuthStatus.loading));

    // final emailAvailability = await authRepo.checkEmailAvalibility(email: userData.email);

    // final isAvailable = emailAvailability.fold(
    //   (error) {
    //     emit(
    //       AuthState(
    //         action: AuthAction.signup,
    //         status: AuthStatus.failure,
    //         errorMessage: error.message,
    //       ),
    //     );
    //     return false;
    //   },
    //   (isAvailable) {
    //     if (!isAvailable) {
    //       emit(
    //         AuthState(
    //           action: AuthAction.signup,
    //           status: AuthStatus.failure,
    //           errorMessage: 'Email is already in use',
    //         ),
    //       );
    //     }

    //     return isAvailable;
    //   },
    // );

    // if (!isAvailable) return;

    final user = await authRepo.signup(userData: userData);

    user.fold(
      (error) => emit(
        AuthState(
          action: AuthAction.signup,
          status: AuthStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (_) => emit(AuthState(action: AuthAction.signup, status: AuthStatus.success)),
    );
  }

}
