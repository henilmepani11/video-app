import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';
import 'package:video_app/domain/validation/ext_on_validation.dart';

class CustomTextFormField extends StatefulWidget {
  final int? maxLines;
  final String label;
  final bool? answerTrue;
  final bool? contentPadding;
  final bool? linkHereTrue;
  final bool? emailValidation;
  final bool? passwordLength;
  final String? validatorText;
  final Widget? suffixIcon;
  final Widget? eyeSuffixIcon;
  final bool? passwordNotMatch;
  final Function? passwordNotMatchFunction;
  final bool? focus;
  final TextEditingController? controller;
  bool obscureText = true;
  final bool? readOnly;

  CustomTextFormField(
      {Key? key,
      required this.label,
      this.answerTrue,
      this.contentPadding = false,
      required this.obscureText,
      this.linkHereTrue,
      this.validatorText,
      this.emailValidation = false,
      this.passwordLength = false,
      this.controller,
      this.maxLines,
      this.suffixIcon,
      this.eyeSuffixIcon,
      this.passwordNotMatch = false,
      this.passwordNotMatchFunction,
      this.readOnly = false,
      this.focus = false})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: widget.answerTrue == true
              ? EdgeInsets.fromLTRB(0, 0.75.h, 0, 0)
              : EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
          child: TextFormField(
            readOnly: widget.readOnly == true ? true : false,
            controller: widget.controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return widget.validatorText;
              } else if (widget.passwordLength == true) {
                if (value.length < 6 || value.length > 16) {
                  return AppString.passwordLength;
                }
              } else if (widget.emailValidation == true) {
                if (value.toString().isEmailValid()) {
                  return AppString.pleaseEnterValidEmailAddress;
                }
              }
              if (widget.passwordNotMatch == true) {
                return widget.passwordNotMatchFunction!(value);
              }
            },
            maxLines: widget.maxLines,
            obscureText: widget.obscureText ? false : true,
            style: CustomTextStyle.txt14W600HintColor,
            cursorColor: AppColor.textFieldHintColor,
            decoration: InputDecoration(
              errorStyle: TextStyle(color: AppColor.red.withOpacity(0.9)),
              contentPadding: widget.contentPadding == true
                  ? const EdgeInsets.all(18)
                  : null,
              suffixIcon: widget.suffixIcon ?? (widget.eyeSuffixIcon),
              hintText: widget.contentPadding == true ? widget.label : null,
              hintStyle: widget.contentPadding == true
                  ? CustomTextStyle.txt15W600Grey
                  : null,
              labelStyle: CustomTextStyle.txt14W600HintColor.copyWith(
                  color: widget.linkHereTrue == true
                      ? AppColor.textFieldHintColor1.withOpacity(0.2)
                      : AppColor.textFieldHintColor),
              floatingLabelStyle: CustomTextStyle.txt14W600primary1
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 17),
              label: widget.answerTrue == true ? null : Text(widget.label),
              errorBorder: widget.answerTrue == true
                  ? CustomBoderStyle.errorOutlineInputBorder
                  : CustomBoderStyle.errorUnderlineInputBorder,
              focusedBorder: widget.answerTrue == true
                  ? CustomBoderStyle.outlineInputBorder
                  : CustomBoderStyle.underlineInputBorder.copyWith(
                      borderSide: BorderSide(
                          color: widget.focus == true
                              ? AppColor.grey
                              : AppColor.primaryColor)),
              focusedErrorBorder: widget.answerTrue == true
                  ? CustomBoderStyle.errorOutlineInputBorder
                  : CustomBoderStyle.errorUnderlineInputBorder,
              disabledBorder: widget.answerTrue == true
                  ? widget.contentPadding == true
                      ? CustomBoderStyle.outlineInputBorder1.copyWith(
                          borderSide: BorderSide(
                              color: widget.linkHereTrue == true
                                  ? AppColor.linkHereTextField
                                  : AppColor.primaryColor.withOpacity(0.4)))
                      : CustomBoderStyle.outlineInputBorder
                  : CustomBoderStyle.underlineInputBorder,
              enabledBorder: widget.answerTrue == true
                  ? widget.contentPadding == true
                      ? CustomBoderStyle.outlineInputBorder1.copyWith(
                          borderSide: BorderSide(
                              color: widget.linkHereTrue == true
                                  ? AppColor.linkHereTextField
                                  : AppColor.primaryColor.withOpacity(0.4)))
                      : CustomBoderStyle.outlineInputBorder
                  : CustomBoderStyle.underlineInputBorder
                      .copyWith(borderSide: BorderSide(color: AppColor.grey)),
              border: widget.answerTrue == true
                  ? widget.contentPadding == true
                      ? CustomBoderStyle.outlineInputBorder1.copyWith(
                          borderSide: BorderSide(
                              color: widget.linkHereTrue == true
                                  ? AppColor.linkHereTextField
                                  : AppColor.primaryColor.withOpacity(0.4)))
                      : CustomBoderStyle.outlineInputBorder
                  : CustomBoderStyle.underlineInputBorder,
            ),
          ),
        ),
      ],
    );
  }
}
