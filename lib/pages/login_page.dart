import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/pages/blocs/bloc_auth/auth_bloc.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text.dart';
import 'package:flutter/material.dart' hide Size;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  bool isLoading = false;
  String? email, password;
  static String id = 'loginPage';

  GlobalKey<FormState> formKey = GlobalKey();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).rceveMessage();
          Navigator.pushNamed(context, ChatPage.id);
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.messageError);
          isLoading = false;
        }
      },
      builder: (context, State) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: Color(0xff2B475E),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 160,
                    child: Image.asset("assets/images/scholar.png"),
                  ),
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontFamily: 'Pacifico',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white, fontSize: 35),
                    textAlign: TextAlign.start,
                  ),
                  CustomFormTextField(
                    label: 'Email',
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomFormTextField(
                    label: 'Password',
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'LOGIN',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(
                          context,
                        ).add(LoginEvent(email: email!, password: password!));
                      } else {}
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don`t have an account?',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Spacer(flex: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
