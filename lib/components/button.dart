import 'package:comment_lines_remover/commons/colors.dart';
import 'package:comment_lines_remover/commons/sizes.dart';
import 'package:comment_lines_remover/components/text.dart';
import 'package:comment_lines_remover/services/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OutlinedBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isIconBtn;
  final bool? isSvgIcon;
  final IconData? icon;
  final String? iconPath;
  final String? label;
  final String toolTip;
  final bool isSmallBtn;
  const OutlinedBtn({
    required this.onPressed,
    super.key, required this.isIconBtn, this.isSvgIcon, this.icon, this.iconPath, this.label, required this.toolTip, required this.isSmallBtn,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: toolTip,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: MySizes.btnHeight,
          width: isSmallBtn? Responsive.isMobile(context)?45: Responsive.isTablet(context) ?50: 60 : Responsive.isMobile(context) || Responsive.isTablet(context) ? 145:200,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: MyColors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
                color: MyColors.primary,
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: MyColors.white,
                  width: 2,
                )),
            child: Center(
              child: isIconBtn?
              isSvgIcon!
                  ? SvgPicture.asset(
                iconPath!,
                colorFilter: const ColorFilter.mode(MyColors.white, BlendMode.srcIn),
                height: 24,
                width: 24,
                fit: BoxFit.cover,
              )
                  : Icon(
                icon,
                color: MyColors.white,
                size: 22,
              ):TextWidget.paragraph(label!, color: MyColors.white,),
            )
          ),
        ),
      ),
    );
  }
}

