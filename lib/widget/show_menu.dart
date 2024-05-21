import 'package:flutter/material.dart';
import 'package:video_app/config/app_color.dart';
import 'package:video_app/config/constants.dart';

List<String> menu = ["Remove Category"];

void showPopupMenu({required Offset offset, context, onTap}) async {
  double left = offset.dx;
  double top = offset.dy;
  await showMenu(
    color: AppColor.white,
    context: context,
    position: RelativeRect.fromLTRB(left, top, 100, 0),
    items: menu
        .map(
          (e) => PopupMenuItem<String>(
            value: e,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              onTap();
            },
            child: Text(e.toString(),
                style: CustomTextStyle.txt14W600HintColor
                    .copyWith(color: AppColor.removeLikedVideosColor)),
          ),
        )
        .toList(),
    elevation: 8.0,
  );
}

List<String> menu1 = ["Remove From Liked Video"];
void showPopupMenu1({required Offset offset, context, onTap}) async {
  double left = offset.dx;
  double top = offset.dy;
  await showMenu(
    color: AppColor.white,
    context: context,
    position: RelativeRect.fromLTRB(left, top, 40, 0),
    items: menu1
        .map(
          (e) => PopupMenuItem<String>(
            value: e,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              onTap();
            },
            child: Text(e.toString(),
                style: CustomTextStyle.txt14W600HintColor
                    .copyWith(color: AppColor.removeLikedVideosColor)),
          ),
        )
        .toList(),
    elevation: 8.0,
  );
}
