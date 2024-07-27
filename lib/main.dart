import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:scholar_chat/cubits/chat_cubit/chat_cubit.dart'; 
import 'package:scholar_chat/firebase_options.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/login_page.dart';
import 'package:scholar_chat/cubits/login_cubit/login_cubit.dart';
import 'package:scholar_chat/cubits/register_cubit/register_cubit.dart';
import 'package:scholar_chat/models/login_page_model.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
         BlocProvider(
          create: (context) => ChatCubit(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginPageModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.id,
        routes: {
          LoginPage.id: (context) => const LoginPage(),
          ChatPage.id: (context) => ChatPage(),
   
        },
      ),
    );
  }
}
