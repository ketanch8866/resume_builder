import 'package:flutter/material.dart';
import 'package:resume_builder/res/theam/app_colors.dart';
import 'package:resume_builder/res/utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final String errorText;
  final String hintText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final FocusNode currentFocusNode;
  final FocusNode? nextFocusNode;
  final Function(String)? onChange;
  final Function()? onTap;
  final bool? info;
  final bool? isreadOnly;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.prefixIcon,
      required this.errorText,
      required this.hintText,
      required this.textInputType,
      required this.currentFocusNode,
      this.onChange,
      this.onTap,
      this.nextFocusNode,
      this.info,
      this.isreadOnly,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: currentFocusNode,
      onFieldSubmitted: (value) {
        if (nextFocusNode != null) {
          Utils.fieldFocusNodeChange(context, currentFocusNode, nextFocusNode!);
        }
      },
      readOnly: isreadOnly ?? false,
      onTap: onTap,
      onChanged: onChange,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.primaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.greyColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.redColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        hintText: hintText,
      ),
      cursorColor: AppColors.primaryColor,
      keyboardType: textInputType,
    );
  }
}

class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final String errorText;
  final String hintText;
  final bool obsecureVisibility;
  final VoidCallback visibility;
  final String? Function(String?)? validator;
  final FocusNode currentFocusNode;
  final FocusNode? nextFocusNode;

  const CustomPasswordTextField(
      {super.key,
      required this.controller,
      required this.errorText,
      required this.hintText,
      required this.obsecureVisibility,
      required this.prefixIcon,
      required this.validator,
      required this.currentFocusNode,
      this.nextFocusNode,
      required this.visibility});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscuringCharacter: '*',
      obscureText: obsecureVisibility,
      focusNode: currentFocusNode,
      validator: validator,
      onFieldSubmitted: (value) {
        if (nextFocusNode != null) {
          Utils.fieldFocusNodeChange(context, currentFocusNode, nextFocusNode!);
        } else {
          currentFocusNode.unfocus();
        }
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.primaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.greyColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.redColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        suffixIcon: IconButton(
            onPressed: visibility,
            icon: obsecureVisibility
                ? const Icon(
                    Icons.visibility_off,
                    color: AppColors.primaryColor,
                  )
                : const Icon(
                    Icons.visibility,
                    color: AppColors.primaryColor,
                  )),
        // errorText: validity ? null : errorText,
        hintText: hintText,
      ),
      cursorColor: AppColors.primaryColor,
    );
  }
}
