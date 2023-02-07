import 'package:flutter/material.dart';
import 'package:social_media/res/color.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.myController,
    required this.focusNode,
    required this.onFieldSubmit,
    required this.onValidator,
    required this.keyBoardType,
    required this.hint,
    this.enable = true,
    this.autoFocus = false,
    required this.obSecureText,
  }) : super(key: key);
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmit;
  final FormFieldValidator onValidator;
  final TextInputType keyBoardType;
  final String hint;
  final bool obSecureText;
  final bool enable, autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmit,
        obscureText: obSecureText,
        keyboardType: keyBoardType,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(height: 0, fontSize: 19),
        enabled: enable,
        autofocus: autoFocus,
        decoration: InputDecoration(
          enabled: enable,
          contentPadding: const EdgeInsets.all(15),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              height: 0,
              color: AppColors.primaryTextTextColor.withOpacity(0.8)),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.textFieldDefaultFocus),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.alertColor),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.textFieldDefaultBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
