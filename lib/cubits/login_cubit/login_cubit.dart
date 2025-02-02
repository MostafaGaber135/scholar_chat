import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(
      LoginLoading(),
    );
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(
        LoginSuccess(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
        emit(LoginFailure(errMessage: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errMessage: 'wrong-password'));
      }
    } catch (e) {
      emit(LoginFailure(errMessage: 'there was an error'));
    }
  }
}
