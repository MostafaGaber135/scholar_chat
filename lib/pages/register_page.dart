import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/register_cubit/register_cubit.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/models/register_page_model.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';


class RegisterPage extends StatelessWidget {
  static String id = 'RegisterPage';

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RegisterPageModel>(context);

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          model.toggleLoading();
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatPage.id, arguments: model.email);
        } else if (state is RegisterFailure) {
          model.toggleLoading();
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                          'REGISTER',
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
                            BlocProvider.of<RegisterCubit>(context)
                                .registerUser(
                                    email: model.email!,
                                    password: model.password!);
                            try {
                              await registerUser(model.email!, model.password!);
                              if (context.mounted) {
                                showSnackBar(context, 'Successful Register');
                                Navigator.pushNamed(context, ChatPage.id);
                              }
                            } on FirebaseAuthException catch (e) {
                              if (context.mounted) {
                                if (e.code == 'weak-password') {
                                  showSnackBar(context,
                                      'The password provided is too weak');
                                } else if (e.code == 'email-already-in-use') {
                                  showSnackBar(context,
                                      'The account already exists for that email.');
                                }
                              }
                            }
                            model.toggleLoading();
                          } else {
                            showSnackBar(context,
                                'Please enter both email and password.');
                          }
                        }
                      },
                      text: 'register',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Color(0XFFC7EDE6)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> registerUser(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
