import 'package:flutter/material.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/home_screen/widgets/custom_bottom_sheet.dart';
import 'package:note_app/view/home_screen/widgets/custom_note_wiget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NoteScreenController noteScreenController = NoteScreenController();
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
        body: noteScreenController.notedb.isEmpty
            ? const Center(
                child: Text("No Data Found"),
              )
            : ListView.separated(
                shrinkWrap: true,
                reverse: true,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) => CustomNoteWidget(
                      title: noteScreenController.notedb[index]["title"],
                      des: noteScreenController.notedb[index]["des"],
                      date: noteScreenController.notedb[index]["date"],
                      noteColor: noteScreenController.notedb[index]["color"],
                      onDeletePressed: () {
                        noteScreenController.deleteData(index);
                        setState(() {});
                      },
                      onEditPressed: () {
                        NoteScreenController.titlecontroller.text =
                            noteScreenController.notedb[index]["title"];
                        NoteScreenController.descontroller.text =
                            noteScreenController.notedb[index]["des"];
                        NoteScreenController.datecontroller.text =
                            noteScreenController.notedb[index]["date"];

                        showModalBottomSheet(
                            isScrollControlled: true,
                            showDragHandle: true,
                            context: context,
                            builder: (context) => CustomBottomSheet(
                                  isEdit: true,
                                  onSavePressed: () {
                                    noteScreenController.editData(index);
                                    NoteScreenController.clearControler();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                ));
                      },
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: noteScreenController.notedb.length));
  }
}
