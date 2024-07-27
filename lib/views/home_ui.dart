import 'package:comment_lines_remover/commons/colors.dart';
import 'package:comment_lines_remover/commons/constants.dart';
import 'package:comment_lines_remover/commons/sizes.dart';
import 'package:comment_lines_remover/commons/strings.dart';
import 'package:comment_lines_remover/components/Dropdown/Controller/chip_config.dart';
import 'package:comment_lines_remover/components/Dropdown/Controller/value_item.dart';
import 'package:comment_lines_remover/components/Dropdown/multiselect_dropdown.dart';
import 'package:comment_lines_remover/components/button.dart';
import 'package:comment_lines_remover/components/pop_ups.dart';
import 'package:comment_lines_remover/components/text.dart';
import 'package:comment_lines_remover/controllers/home_controller.dart';
import 'package:comment_lines_remover/services/copy_paste_service.dart';
import 'package:comment_lines_remover/services/pdf_generator.dart';
import 'package:comment_lines_remover/services/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) || Responsive.isTablet(context) ? 20 : 40, vertical: Responsive.isMobile(context) ? 15 : 30),
          child: Column(
            children: [
              controller.isFullScreen ? Container() : appBar(context),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        border: Border.all(
                          color: MyColors.secondary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          controller.isFullScreen ? Container() : toolsBar(context),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: controller.textEditingController,
                                        maxLines: null,
                                        decoration: const InputDecoration(border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )))
            ],
          ),
        ),
      ),
      floatingActionButton: controller.isFullScreen
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40),
              child: fullScreenBtn(),
            )
          : null,
    );
  }

  Widget appBar(BuildContext context) {
    return SizedBox(
      height: Responsive.isMobile(context)
          ? 90
          : Responsive.isTablet(context)
              ? 120
              : 200,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 600,
              child: Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget.heading(MyStrings.appName, context, color: MyColors.primary),
                    Align(alignment: Alignment.centerRight, child: TextWidget.paragraphBold(MyStrings.appSlogan, context, color: MyColors.primary)),
                  ],
                ),
              ),
            ),
          ),
          Image.asset(
            Constants.logo,
          ),
        ],
      ),
    );
  }

  Widget toolsBar(BuildContext context) {
    double height = Responsive.isMobile(context)
        ? 170
        : Responsive.isTablet(context)
            ? 130
            : 65;
    return Container(
      decoration: const BoxDecoration(color: MyColors.secondary, borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      height: height,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Responsive.isMobile(context)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: copyBtn(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: pasteBtn(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: clearBtn(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: downloadBtn(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: fullScreenBtn(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: languageDropdown(),
                      )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: commentDropdown(),
                      )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: removeBtn(),
                      ),
                    ],
                  )
                ],
              )
            : Responsive.isTablet(context)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: removeBtn(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: copyBtn(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: pasteBtn(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: clearBtn(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: downloadBtn(context),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: fullScreenBtn(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: languageDropdown(),
                          )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: commentDropdown(),
                          )),
                        ],
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: removeBtn(),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: languageDropdown(),
                      )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: commentDropdown(),
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: copyBtn(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: pasteBtn(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: clearBtn(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: downloadBtn(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: fullScreenBtn(),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget languageDropdown() {
    return SizedBox(
      height: MySizes.btnHeight,
      width: 200,
      child: MultiSelectDropDown(
        selectedOptions: List.generate(controller.selectedLanguagesList.length, (index) => ValueItem(label: controller.selectedLanguagesList.elementAt(index),value: controller.selectedLanguagesList.elementAt(index)),),
        onOptionSelected: (options) {
          setState(() {
            for(ValueItem item in options){
              for(String comment in Constants.languagesCommentsPairs[item.value]!){
                controller.selectedCommentsList.add(comment);
              }
            }
          });
          setState(() {

          });
        },
        options: List.generate(
          Constants.languages.length,
          (index) => ValueItem(label: Constants.languages[index], value: Constants.languages[index]),
        ),
        selectionType: SelectionType.multi,
        borderColor: MyColors.primary,
        chipConfig: const ChipConfig(
          wrapType: WrapType.scroll,
          backgroundColor: MyColors.primary,
        ),
        dropdownHeight: 180,
        optionTextStyle: const TextStyle(fontSize: 16),
        selectedOptionIcon: const Icon(Icons.check_circle),
        borderRadius: 5,
        borderWidth: 0.5,
        hint: MyStrings.languages,
      ),
    );
  }

  Widget commentDropdown() {
    return SizedBox(
      height: MySizes.btnHeight,
      width: 200,
      child: MultiSelectDropDown(
        selectedOptions: List.generate(controller.selectedCommentsList.length, (index) => ValueItem(label: controller.selectedCommentsList.elementAt(index),value: controller.selectedCommentsList.elementAt(index)),),
        onOptionSelected: (options) {
          controller.selectedCommentsList = List.generate(options.length, (index) => options[index].label).toSet();
        },
        options: List.generate(
          Constants.singleComments.length + Constants.multiComments.length,
          (index) => ValueItem(label: index < Constants.singleComments.length ? Constants.singleComments[index] : Constants.multiComments[(Constants.singleComments.length - index).abs()], value: index < Constants.singleComments.length ? Constants.singleComments[index] : Constants.multiComments[(Constants.singleComments.length - index).abs()]),
        ),
        selectionType: SelectionType.multi,
        borderColor: MyColors.primary,
        chipConfig: const ChipConfig(wrapType: WrapType.scroll, backgroundColor: MyColors.primary),
        dropdownHeight: 180,
        optionTextStyle: const TextStyle(fontSize: 16),
        selectedOptionIcon: const Icon(Icons.check_circle),
        borderRadius: 5,
        borderWidth: 0.5,
        hint: MyStrings.comments,
      ),
    );
  }

  Widget copyBtn() {
    return OutlinedBtn(
      isIconBtn: true,
      toolTip: MyStrings.copy,
      onPressed: () {
        CopyPasteService.setData(controller.textEditingController.text);
        PopUp.showPopup(context, MyStrings.copiedSuccess);
      },
      isSvgIcon: false,
      icon: Icons.content_copy_rounded,
      isSmallBtn: true,
    );
  }

  Widget pasteBtn() {
    return OutlinedBtn(
      isIconBtn: true,
      toolTip: MyStrings.paste,
      onPressed: () async {
        String? data = await CopyPasteService.getData();
        controller.textEditingController.text = data ?? "";
      },
      isSvgIcon: false,
      icon: Icons.paste,
      isSmallBtn: true,
    );
  }

  Widget clearBtn() {
    return OutlinedBtn(
      isIconBtn: true,
      toolTip: MyStrings.clear,
      onPressed: () {
        controller.textEditingController.clear();
      },
      isSvgIcon: false,
      icon: Icons.playlist_remove_rounded,
      isSmallBtn: true,
    );
  }

  Widget downloadBtn(BuildContext context) {
    return OutlinedBtn(
      isIconBtn: true,
      toolTip: MyStrings.download,
      onPressed: () async {
        if (!kIsWeb) {
          final plugin = DeviceInfoPlugin();
          final android = await plugin.androidInfo;
          ph.PermissionStatus status;
          if (android.version.sdkInt < 33) {
            status = await ph.Permission.storage.request();
          } else {
            status = ph.PermissionStatus.granted;
          }

          if (status == ph.PermissionStatus.granted) {
            int isValidCheck = controller.textEditingController.text == ''? 1:0;
            switch (isValidCheck) {
              case 0:
                {
                  if (await pdfGenerator(controller.textEditingController.text)) {
                    if (context.mounted) {
                      {
                        PopUp.showPopup(context, MyStrings.downloadSuccess);
                      }
                    }
                  } else {
                    if (context.mounted) {
                      PopUp.showPopup(context, MyStrings.wrong);
                    }
                  }
                  break;
                }
              case 1:
                {
                  if (context.mounted) {
                    PopUp.showPopup(context, MyStrings.empty);
                  }
                  break;
                }
            }
          } else if (status == ph.PermissionStatus.denied) {
            PopUp.showPopup(context, MyStrings.deniedMsg);
          } else if (status == ph.PermissionStatus.permanentlyDenied) {
            PopUp.showPopupOpenSettingsForStorage(context);
          } else {
            PopUp.showPopup(context, MyStrings.wrong);
          }
        }
        else{
          int isValidCheck = controller.textEditingController.text == ''? 1:0;
          switch (isValidCheck) {
            case 0:
              {
                if (await pdfGenerator(controller.textEditingController.text)) {
                  if (context.mounted) {
                    {
                      PopUp.showPopup(context, MyStrings.downloadSuccess);
                    }
                  }
                } else {
                  if (context.mounted) {
                    PopUp.showPopup(context, MyStrings.wrong);
                  }
                }
                break;
              }
            case 1:
              {
                if (context.mounted) {
                  PopUp.showPopup(context, MyStrings.empty);
                }
                break;
              }
          }
        }
      },
      isSvgIcon: false,
      icon: Icons.file_download_outlined,
      isSmallBtn: true,
    );
  }

  Widget fullScreenBtn() {
    return OutlinedBtn(
      isIconBtn: true,
      toolTip: controller.isFullScreen ? MyStrings.exitFullScreen : MyStrings.fullScreen,
      onPressed: () {
        setState(() {
          controller.isFullScreen = controller.isFullScreen ? false : true;
        });
      },
      isSvgIcon: false,
      icon: controller.isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
      isSmallBtn: true,
    );
  }

  Widget removeBtn(){
    return OutlinedBtn(
      isIconBtn: false,
      toolTip: MyStrings.remove,
      onPressed: () async {
        if(controller.textEditingController.text == ''){
          PopUp.showPopup(context, MyStrings.empty);
        }else if(controller.selectedCommentsList.isEmpty){
          PopUp.showPopup(context, MyStrings.commentEmpty);
        }else{
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator()
                );
              });
          for(String comment in controller.selectedCommentsList){
            await controller.commentsRemover(comment);
          }
          Navigator.pop(context);
        }
      },
      label: MyStrings.remove,
      isSmallBtn: false,
    );
  }
}
