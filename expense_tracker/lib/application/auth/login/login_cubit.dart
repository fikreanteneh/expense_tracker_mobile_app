import 'package:equatable/equatable.dart';
import 'package:expense_tracker/fetcher.dart';
import 'package:expense_tracker/user_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Fetcher _fetcher;

  LoginCubit(this._fetcher) : super(LoginState.initial());

  void userNameChanged(String value) {
    emit(
      state.copyWith(
        username: value,
        status: LoginStatus.initial,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: LoginStatus.initial,
      ),
    );
  }

  Future<void> loadCachedUser() async {
    User user = await User.load();
    if (user != User.empty) {
      emit(state.copyWith(status: LoginStatus.success, user: user));
    }
  }

  Future<void> logInWithCredentials() async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      User? user = await _fetcher.signInUser(
        username: state.username,
        password: state.password,
      );
      if (user != User.empty) {
        emit(state.copyWith(status: LoginStatus.success, user: user));
        return;
      } else {
        emit(state.copyWith(status: LoginStatus.error));
      }
    } catch (error) {
      String errorMessage = 'An error occurred. Please try again.';
      if (error is Exception) {
        errorMessage = error.toString().replaceAll('Exception:', '');
      }
      emit(state.copyWith(status: LoginStatus.error, error: errorMessage));
    }
  }

  // Future<bool> forgetPassword(
  //     {required phoneNumber,
  //     required quesiton,
  //     required answer,
  //     required newPassword}) async {
  //   if (state.status == LoginStatus.submitting) return true;
  //   emit(state.copyWith(status: LoginStatus.submitting));
  //   try {
  //     bool result = await _authRepository.forgetPassword(
  //         phoneNumber, quesiton, answer, newPassword);
  //     if (result) {
  //       emit(state.copyWith(status: LoginStatus.success));
  //       return true;
  //     } else {
  //       emit(state.copyWith(status: LoginStatus.error));
  //       return false;
  //     }
  //   } catch (error) {
  //     String errorMessage = 'An error occurred. Please try again.';
  //     if (error is Exception) {
  //       errorMessage = error.toString().replaceAll('Exception:', '');
  //       emit(state.copyWith(status: LoginStatus.error, error: errorMessage));
  //     }
  //     emit(state.copyWith(status: LoginStatus.error, error: errorMessage));
  //     return false;
  //   }
  // }

  Future<void> logout() async {
    await User.logout();
    emit(LoginState.initial());
  }

  // Future<bool> changePassowrd(oldPassword, newPassword, token, id) async {
  //   if (state.status == LoginStatus.submitting) return true;
  //   emit(state.copyWith(status: LoginStatus.submitting));
  //   try {
  //     bool result = await _authRepository.changePassword(
  //         oldPassword: oldPassword,
  //         newPassword: newPassword,
  //         token: token,
  //         id: id);

  //     if (result) {
  //       emit(state.copyWith(status: LoginStatus.success));
  //       return true;
  //     } else {
  //       emit(state.copyWith(status: LoginStatus.error));
  //       return false;
  //     }
  //   } catch (error) {
  //     String errorMessage = 'An error occurred. Please try again.';
  //     if (error is Exception) {
  //       errorMessage = error.toString().replaceAll('Exception:', '');
  //     }
  //     emit(state.copyWith(status: LoginStatus.error, error: errorMessage));
  //     return false;
  //   }
  // }

  // Future<void> editProfile(attribute, value, token) async {
  //   if (state.status == LoginStatus.submitting) return;
  //   emit(state.copyWith(status: LoginStatus.submitting));
  //   try {
  //     User user = await _authRepository.editProfile(attribute, value, token);

  //     if (user != User.empty) {
  //       await _authRepository.removeCachedUser();
  //       await _authRepository.cacheUser(user);
  //       emit(state.copyWith(status: LoginStatus.success, user: user));
  //       return;
  //     }
  //   } catch (_) {}
  // }

  // Future<bool> deleteProfile(id, token) async {
  //   if (state.status == LoginStatus.submitting) return true;
  //   emit(state.copyWith(status: LoginStatus.submitting));
  //   try {
  //     bool result = await _authRepository.deleteProfile(id, token);
  //     if (result) {
  //       await _authRepository.removeCachedUser();
  //       emit(state.copyWith(status: LoginStatus.initial));
  //       return true;
  //     }
  //     return false;
  //   } catch (error) {
  //     String errorMessage = 'An error occurred. Please try again.';
  //     if (error is Exception) {
  //       errorMessage = error.toString().replaceAll('Exception:', '');
  //     }
  //     emit(state.copyWith(status: LoginStatus.error, error: errorMessage));
  //     return false;
  //   }
  // }
}
