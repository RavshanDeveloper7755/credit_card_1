import 'package:flutter/material.dart';

import '../auth.dart';

mixin AuthMixin on State<AuthPage>{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}