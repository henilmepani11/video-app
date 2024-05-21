import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/app_string.dart';
import 'package:video_app/config/constants.dart';

class CustomDropDownField extends StatelessWidget {
  final String validatorText;
  final List<DropdownMenuItem>? items;
  final Function onChanged;
  const CustomDropDownField(
      {Key? key,
      required this.validatorText,
      required this.items,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorText;
        }
        return null;
      },
      icon: Icon(Icons.keyboard_arrow_down_outlined,
          size: 20.sp, color: AppColor.textFieldHintColor),
      dropdownColor: AppColor.backgroundColor21,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: items,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: AppColor.red.withOpacity(0.9)),
        errorBorder: CustomBoderStyle.errorOutlineInputBorder,
        contentPadding: const EdgeInsets.all(16),
        hintText: AppString.enterYourQuestion,
        hintStyle: CustomTextStyle.txt14W600HintColor,
        border: CustomBoderStyle.outlineInputBorder,
        focusedErrorBorder: CustomBoderStyle.errorOutlineInputBorder,
        focusedBorder: CustomBoderStyle.outlineInputBorder,
        enabledBorder: CustomBoderStyle.outlineInputBorder,
      ),
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
