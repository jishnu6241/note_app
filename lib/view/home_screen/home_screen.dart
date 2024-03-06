import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/utils/colorconstant.dart';
import 'package:note_app/view/home_screen/widgets/custom_bottom_sheet.dart';
import 'package:note_app/view/home_screen/widgets/custom_note_wiget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NoteScreenController noteScreenController = NoteScreenController();
  var myBox = Hive.box("noteBox");
  @override
  void initState() {
    noteScreenController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff00bfff),
          onPressed: () {
            NoteScreenController.clearControler();
            showModalBottomSheet(
              isScrollControlled: true,
              showDragHandle: true,
              context: context,
              builder: (context) => CustomBottomSheet(
                onSavePressed: () {
                  noteScreenController.addData();
                  NoteScreenController.clearControler();
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            );
          },
          elevation: 0,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Notes',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
          ),
          centerTitle: true,
        ),
        body: noteScreenController.noteKeys.isEmpty
            ? const Center(
                child: Text("No Data Found"),
              )
            : ListView.separated(
                shrinkWrap: true,
                reverse: true,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  var element = myBox.get(noteScreenController.noteKeys[index]);
                  return CustomNoteWidget(
                    title: element["title"],
                    des: element["des"],
                    date: element["date"],
                    noteColor: element["color"] != null
                        ? NoteScreenController.noteColor[element["color"]]
                        : Colors.blue[100],
                    onDeletePressed: () {
                      noteScreenController
                          .deleteData(noteScreenController.noteKeys[index]);
                      setState(() {});
                    },
                    onEditPressed: () {
                      NoteScreenController.titlecontroller.text =
                          element["title"];
                      NoteScreenController.descontroller.text = element["des"];
                      NoteScreenController.datecontroller.text =
                          element["date"];

                      showModalBottomSheet(
                          isScrollControlled: true,
                          showDragHandle: true,
                          context: context,
                          builder: (context) => CustomBottomSheet(
                                isEdit: true,
                                onSavePressed: () {
                                  noteScreenController.editData(
                                      noteScreenController.noteKeys[index]);

                                  setState(() {});
                                  NoteScreenController.clearControler();
                                  Navigator.pop(context);
                                },
                              ));
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: noteScreenController.noteKeys.length));
  }
}
