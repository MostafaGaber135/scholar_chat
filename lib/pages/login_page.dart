import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/cubits/login_cubit/login_cubit.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/models/login_page_model.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';

import 'chat_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  static String id = 'LoginPage';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginPageModel>(context);

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          model.toggleLoading();
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id, arguments: model.email);
        } else if (state is LoginFailure) {
          model.toggleLoading();
          showSnackBar(context, state.errMessage);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: model.isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: model.formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 75),
                  Image.asset('assets/images/scholar.png', height: 100),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'pacifico'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 75),
                  const Row(
                    children: [
                      Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomFormTextField(
                    onChanged: (data) {
                      model.setEmail(data);
                    },
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 10),
                  CustomFormTextField(
                    obscureText: model.obscureText,
                    onChanged: (data) {
                      model.setPassword(data);
                    },
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        model.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        model.toggleObscureText();
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onTap: () async {
                      if (model.formKey.currentState!.validate()) {
                        if (model.email != null && model.password != null) {
                          BlocProvider.of<LoginCubit>(context).loginUser(
                              email: model.email!, password: model.password!);
                        } else {
                          showSnackBar(
                              context, 'Please enter both email and password.');
                        }
                      }
                    },
                    text: 'login',
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have an account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          '  Register',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
