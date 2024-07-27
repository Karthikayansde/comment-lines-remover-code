import 'package:comment_lines_remover/components/Dropdown/multiselect_dropdown.dart';
import 'package:flutter/material.dart';

class HomeController{
  bool isFullScreen = false;
  TextEditingController textEditingController = TextEditingController();
  Set<String> selectedLanguagesList = {};
  Set<String> selectedCommentsList = {};
  MultiSelectController languagesMultiController = MultiSelectController();
  MultiSelectController commentsMultiController = MultiSelectController();

  Future<void> commentsRemover(String comment)async {
    String resultString = '';
    switch(comment){
      case "#":{
        for(int index = 0; index < textEditingController.text.characters.length; index++){
          if(textEditingController.text.characters.elementAt(index) == "#"){
            int i = index;
            while(textEditingController.text.characters.elementAt(i) != "\n" && textEditingController.text.characters.elementAt(i) != '\0'&&i < textEditingController.text.characters.length){
              await Future.delayed(const Duration(microseconds: 1));
              i++;
              continue;
            }
            i--;
            index = i;
          }else{
            await Future.delayed(const Duration(microseconds: 1));
            resultString += textEditingController.text.characters.elementAt(index);
          }
        }
        textEditingController.text = resultString;
        break;
      }
      case "//" || "///":{
        for(int index = 0; index < textEditingController.text.characters.length; index++){
          if(textEditingController.text.characters.elementAt(index) == "/" && textEditingController.text.characters.elementAt(index+1) == "/"){
            index++;
            int i = index;
            while(textEditingController.text.characters.elementAt(i) != "\n" && textEditingController.text.characters.elementAt(i) != '\0'&&i < textEditingController.text.characters.length){
              await Future.delayed(const Duration(microseconds: 1));
              i++;
              continue;
            }
            i--;
            index = i;
          }else{
            await Future.delayed(const Duration(microseconds: 1));
            resultString += textEditingController.text.characters.elementAt(index);
          }
        }
        textEditingController.text = resultString;
        break;
      }
      case "--":{
        for(int index = 0; index < textEditingController.text.characters.length; index++){
          if(textEditingController.text.characters.elementAt(index) == "-" && textEditingController.text.characters.elementAt(index+1) == "-"){
            index++;
            int i = index;
            while(textEditingController.text.characters.elementAt(i) != "\n" && textEditingController.text.characters.elementAt(i) != '\0'&&i < textEditingController.text.characters.length){
              await Future.delayed(const Duration(microseconds: 1));
              i++;
              continue;
            }
            i--;
            index = i;
          }else{
            await Future.delayed(const Duration(microseconds: 1));
            resultString += textEditingController.text.characters.elementAt(index);
          }
        }
        textEditingController.text = resultString;
        break;
      }
      case "/*  */":{
        while (true) {
          int startIndexOfComment = textEditingController.text.indexOf('/*');
          if (startIndexOfComment == -1) {
            break;
          }
          int endIndexOfComment = textEditingController.text.indexOf('*/', startIndexOfComment + 2);
          if (endIndexOfComment == -1) {
            break;
          }
          textEditingController.text = textEditingController.text.replaceRange(startIndexOfComment, endIndexOfComment + 2, '');
        }
        break;
      }
      case "<!--  -->":{
        while(true){
          int startIndexOfComment = textEditingController.text.indexOf('<!--');
          if (startIndexOfComment == -1) {
            break;
          }
          int endIndexOfComment = textEditingController.text.indexOf('-->', startIndexOfComment + 3);
          if (endIndexOfComment == -1) {
            break;
          }
          textEditingController.text = textEditingController.text.replaceRange(startIndexOfComment, endIndexOfComment + 3, '');
        }
        break;
      }

    }
  }

}