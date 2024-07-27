import 'package:comment_lines_remover/services/responsive.dart';
import 'package:flutter/material.dart';

class TextWidget extends Text {
  const TextWidget(
      super.data, {
        super.key,
        super.textAlign,
        super.style,
        super.overflow,
      });

  factory TextWidget.heading(String data, BuildContext context, {Color? color}) {
    return TextWidget(
      data,
      style: TextStyle(fontSize: Responsive.isMobile(context)?14.5:Responsive.isTablet(context)?22: 32, fontWeight: FontWeight.w700, color: color,overflow: TextOverflow.ellipsis,),
    );
  }
  factory TextWidget.paragraphBold(String data, BuildContext context, {Color? color}) {
    return TextWidget(
      data,
      style: TextStyle(fontSize: Responsive.isMobile(context)?10:Responsive.isTablet(context)?16:20, fontWeight: FontWeight.w700, color: color,overflow: TextOverflow.ellipsis,),
    );
  }
  factory TextWidget.paragraph(String data, {Color? color}) {
    return TextWidget(
      data,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: color,overflow: TextOverflow.ellipsis,),
    );
  }
  factory TextWidget.paragraphPop(String data, {Color? color}) {
    return TextWidget(
      data,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: color,),
    );
  }

}