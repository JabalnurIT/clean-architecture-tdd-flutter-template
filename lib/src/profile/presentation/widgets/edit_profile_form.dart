import 'package:flutter/material.dart';

import '../../../../core/common/widgets/i_fields.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/utils/core_utils.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({
    required this.nameController,
    required this.emailController,
    required this.formKey,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nama',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryColour),
            ),
            const SizedBox(height: 10),
            IFields(
              controller: widget.nameController,
              hintText: 'Nama',
            ),
            const SizedBox(height: 25),
            const Text(
              'Email',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.primaryColour),
            ),
            const SizedBox(height: 10),
            IFields(
              controller: widget.emailController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              overrideValidator: true,
              validator: (value) {
                return CoreUtils.emailValidator(value);
              },
            ),
          ],
        ));
  }
}
