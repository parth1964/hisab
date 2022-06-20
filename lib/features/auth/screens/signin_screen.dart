import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/features/auth/screens/create_account_screen.dart';

import '/controllers/auth_controller.dart';
import '../widgets/custom_text_form_field.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final authCon = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _signIn(BuildContext context) {
    var data = {
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
    };
    authCon.signIn(data: data, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                keyboardType: TextInputType.emailAddress,
                label: "Email*",
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                label: "Password*",
                controller: _passwordController,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Get.off(CreateAccountScreen());
                },
                child: const Text("Don't have account ?"),
              ),
              const SizedBox(height: 20),
              const Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signIn(context);
                      }
                    },
                    child: const Text("Sign In")),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
