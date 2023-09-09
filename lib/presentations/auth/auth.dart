import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main/screens/cards/cards_page.dart';
import 'bloc/auth_bloc.dart';
import 'mixin/auth_mixin.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with AuthMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (_, state) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return const CardsPage();
            } else {
              return Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(30.0),
                              child: Icon(Icons.credit_card_outlined, size: 100, color: Colors.blueAccent,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5,),
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: "Enter your email",
                                  labelStyle: const TextStyle(
                                    color: Color(0xFF417BEA),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  fillColor: Colors.green,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFF417BEA),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(top: 5,),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Enter your password",
                                  labelStyle: const TextStyle(
                                    color: Color(0xFF417BEA),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  fillColor: Colors.green,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF417BEA),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50,bottom: 5),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(fixedSize: Size(350, 55), backgroundColor: Color(0xFF417BEA)),
                                onPressed: () {
                                  context.read<AuthBloc>().add(LoginEvent(
                                      email: emailController.text,
                                      password: passwordController.text));
                                },
                                child: const Text('Login', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(fixedSize: Size(350, 55), backgroundColor: Color(0xFF417BEA)),
                              onPressed: () {
                                context.read<AuthBloc>().add(SignUpEvent(
                                  email: emailController.text,
                                  password: passwordController.text,));
                              },
                              child: const Text('Sign Up', style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}


