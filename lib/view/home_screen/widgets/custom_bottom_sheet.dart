import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/utils/colorconstant.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
    required this.onSavePressed,
    this.isEdit = false,
  });

  final VoidCallback onSavePressed;
  final bool isEdit;
  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  List noteColor = [
    Colors.blue[100],
    Colors.red[100],
    Colors.green[100],
    Colors.yellow[100],
  ];
  var selectedColorIndex = 0;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, bottomSetState) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        label: const Text(
                          "Title",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.6))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.6)))),
                    controller: NoteScreenController.titlecontroller,
                    validator: (value) {
                      if (NoteScreenController
                          .titlecontroller.text.isNotEmpty) {
                        return null;
                      } else {
                        return "Enter a valid Title";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: const Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.6))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.6)))),
                    controller: NoteScreenController.descontroller,
                    validator: (value) {
                      if (NoteScreenController.descontroller.text.isNotEmpty) {
                        return null;
                      } else {
                        return "Enter a valid Description";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2025));

                              if (pickedDate != null) {
                                String formatedDate =
                                    DateFormat("d MMM yyy").format(pickedDate);
                                NoteScreenController.datecontroller.text =
                                    formatedDate;
                              }
                            },
                            child: const Icon(Icons.calendar_month_outlined)),
                        label: const Text(
                          "Date",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.6))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.6)))),
                    controller: NoteScreenController.datecontroller,
                    validator: (value) {
                      if (NoteScreenController.datecontroller.text.isNotEmpty) {
                        return null;
                      } else {
                        return "Select a valid Date";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 55,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                NoteScreenController obj =
                                    NoteScreenController();
                                selectedColorIndex = index;
                                obj.onColorSelection(
                                    noteColor[selectedColorIndex]);
                                bottomSetState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: selectedColorIndex == index
                                        ? Border.all(
                                            width: 2.3,
                                            color: ColorContant.selblue)
                                        : null,
                                    color: noteColor[index]),
                                width: 55,
                              ),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 25,
                            ),
                        itemCount: 4),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          NoteScreenController.clearControler();
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.9),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.7)),
                          )),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            widget.onSavePressed();
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.9),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            widget.isEdit ? "Update" : "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.7)),
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
