import 'package:comment_lines_remover/commons/colors.dart';
import 'package:comment_lines_remover/commons/strings.dart';
import 'package:comment_lines_remover/components/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class PopUp {
  static showPopup(BuildContext context, String content){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextWidget.paragraphPop(content, color: MyColors.primary),
            actions: [ElevatedButton(onPressed: () => Navigator.pop(context), child: TextWidget.paragraph(MyStrings.ok, color: MyColors.primary))],
          );
        });
  }
  static showPopupCancel(BuildContext context, String content) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextWidget.paragraphPop(content, color: MyColors.primary),
            actions: [
              ElevatedButton(onPressed: () {
              Navigator.of(context).pop(false);
            }, child: TextWidget.paragraphPop(MyStrings.cancel, color: MyColors.primary)),
              ElevatedButton(onPressed: () {
                SystemNavigator.pop();
            }, child: TextWidget.paragraphPop(MyStrings.ok, color: MyColors.primary,))],
          );
        }
        );
  }

  static showPopupOpenSettingsForStorage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextWidget.paragraphPop('Permission Required',color: MyColors.primary,),
            content: Wrap(
              children: [
                Column(
                  children: [
                    TextWidget.paragraphPop('        To download and save code locally, please grant storage permission to save the code PDFs on your device.',color: MyColors.primary),
                    Align(
                      alignment: Alignment.center,
                      child: TextWidget.paragraphPop('1. Click on Open App Settings\n2. CLick on App permissions\n3. Turn on Storage',color: MyColors.primary),
                    )
                  ],
                ),
              ],
            ),
            actions: [
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
            }, child: TextWidget.paragraphPop(MyStrings.cancel,color: MyColors.primary)),
              ElevatedButton(onPressed: () async {
                await openAppSettings();
            }, child: TextWidget.paragraphPop(MyStrings.openSettings,color: MyColors.primary))],
          );
        }
        );
  }

}
