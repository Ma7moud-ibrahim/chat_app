import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        emit(LoginSuccess());
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'user-not-found') {
          emit(LoginFailure(messageError: 'user not found'));
        } else if (ex.code == 'wrong-password') {
          emit(LoginFailure(messageError: 'wrong password'));
        }
      } catch (e) {
        emit(LoginFailure(messageError: 'something went wrong'));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(RegisterSuccess());
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'weak-password') {
          emit(RegisterFailure(errorMessage: 'weak password'));
        } else if (ex.code == 'email-already-in-use') {
          emit(RegisterFailure(errorMessage: 'email already exists'));
        }
      } catch (e) {
        emit(RegisterFailure(errorMessage: 'something went wrong'));
      }
    });
  }
}
