import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NoteScreenController {
  static TextEditingController titlecontroller = TextEditingController();
  static TextEditingController descontroller = TextEditingController();
  static TextEditingController datecontroller = TextEditingController();
  static int selecteColorIndex = 0;
  List notedb = [];
  List noteKeys = [];
  var myBox = Hive.box("noteBox");

  static List noteColor = [
    Colors.blue[100],
    Colors.red[100],
    Colors.green[100],
    Colors.yellow[100],
  ];

//ADD Function Controller
  void addData() {
    myBox.add(
      {
        "title": titlecontroller.text,
        "des": descontroller.text,
        "date": datecontroller.text,
        "color": selecteColorIndex
      },
    );
    noteKeys = myBox.keys.toList();
    // notedb.add(
    //   {
    //     "title": titlecontroller.text,
    //     "des": descontroller.text,
    //     "date": datecontroller.text,
    //     // "color": selectedColor
    //   },
    // );
  }

  //Delete Function Controller
  void deleteData(var key) {
    myBox.delete(key);
    init();

    // notedb.removeAt(index);
  }

  void editData(int key) {
    myBox.put(key, {
      "title": titlecontroller.text,
      "des": descontroller.text,
      "date": datecontroller.text,
      "color": selecteColorIndex
    });
    // notedb[index] = {
    //   "title": titlecontroller.text,
    //   "des": descontroller.text,
    //   "date": datecontroller.text,
    //   "color": selectedColor
    // };
  }

  static void clearControler() {
    titlecontroller.clear();
    descontroller.clear();
    datecontroller.clear();
  }

  void onColorSelection(int newColorIndex) {
    selecteColorIndex = newColorIndex;
  }

  init() {
    noteKeys = myBox.keys.toList();
  }
}
