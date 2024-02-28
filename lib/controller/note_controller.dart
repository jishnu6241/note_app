import 'package:flutter/material.dart';

class NoteScreenController {
  static TextEditingController titlecontroller = TextEditingController();
  static TextEditingController descontroller = TextEditingController();
  static TextEditingController datecontroller = TextEditingController();
  static Color selectedColor = const Color(0xffb2e3ff);
  List notedb = [];

//ADD Function Controller
  void addData() {
    notedb.add(
      {
        "title": titlecontroller.text,
        "des": descontroller.text,
        "date": datecontroller.text,
        "color": selectedColor
      },
    );
  }

  //Delete Function Controller
  void deleteData(int index) {
    notedb.removeAt(index);
  }

  void editData(int index) {
    notedb[index] = {
      "title": titlecontroller.text,
      "des": descontroller.text,
      "date": datecontroller.text,
      "color": selectedColor
    };
  }

  static void clearControler() {
    titlecontroller.clear();
    descontroller.clear();
    datecontroller.clear();
  }

  void onColorSelection(Color newColor) {
    selectedColor = newColor;
  }
}
