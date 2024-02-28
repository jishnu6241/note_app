import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class CustomNoteWidget extends StatefulWidget {
  const CustomNoteWidget({
    super.key,
    required this.title,
    required this.des,
    required this.date,
    required this.noteColor,
    this.onDeletePressed,
    this.onEditPressed,
  });
  final String title;
  final String des;
  final String date;
  final Color noteColor;
  final void Function()? onDeletePressed;
  final void Function()? onEditPressed;
  @override
  State<CustomNoteWidget> createState() => _CustomNoteWidgetState();
}

class _CustomNoteWidgetState extends State<CustomNoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: widget.noteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: widget.onEditPressed,
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: widget.onDeletePressed,
                        icon: const Icon(Icons.delete)),
                  ],
                )
              ],
            ),
            Text(
              widget.des,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.6)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.date,
                  style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.8)),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      Share.share(
                          "${widget.title},${widget.des},${widget.date}");
                    },
                    icon: const Icon(Icons.share)),
              ],
            )
          ],
        ));
  }
}
