import 'package:clean_architecture_tdd_flutter_template/core/common/widgets/i_fields.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
    required this.emailController,
    required this.formKey,
    super.key,
  });

  final TextEditingController usernameController;
  final TextEditingController nameController;
  final TextEditingController emailController;

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            IFields(
              controller: widget.nameController,
              hintText: 'Name',
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 25),
            IFields(
              controller: widget.emailController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 25),
            IFields(
              controller: widget.usernameController,
              hintText: 'Username',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 25),
            IFields(
              controller: widget.passwordController,
              hintText: 'Password',
              obscureText: obscurePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
                icon: Icon(
                  obscurePassword ? IconlyLight.show : IconlyLight.hide,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 25),
            IFields(
              controller: widget.confirmPasswordController,
              hintText: 'Confirm Password',
              obscureText: obscureConfirmPassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureConfirmPassword = !obscureConfirmPassword;
                  });
                },
                icon: Icon(
                  obscureConfirmPassword ? IconlyLight.show : IconlyLight.hide,
                  color: Colors.grey,
                ),
              ),
              overrideValidator: (widget.confirmPasswordController.text.isEmpty)
                  ? false
                  : true,
              validator: (value) {
                if (value != widget.passwordController.text) {
                  return 'Password does not match';
                }
                return null;
              },
            ),
          ],
        ));
  }
}
