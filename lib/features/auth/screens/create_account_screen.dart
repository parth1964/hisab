import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/controllers/auth_controller.dart';
import 'package:hisab/features/auth/screens/signin_screen.dart';
import 'package:hisab/models/user.dart' as user;

import '../widgets/custom_text_form_field.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});
  final authCon = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  _createAccount(BuildContext context) {
    var data = user.User(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _nameController.text,
      accountCreatedDate: DateTime.parse(DateTime.now().toString()),
    ).toMap();
    authCon.createAccount(data: data, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Create account"),
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
                keyboardType: TextInputType.visiblePassword,
                label: "Password*",
                controller: _passwordController,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                label: "Name*",
                controller: _nameController,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Get.off(SigninScreen());
                },
                child: const Text("Already have account ?"),
              ),
              const SizedBox(height: 20),
              const Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _createAccount(context);
                    }
                  },
                  child: const Text("Create account"),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
