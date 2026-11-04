import 'package:flutter/material.dart';

import '../utils/my_colors.dart';
import '../utils/my_fonts.dart';
import 'my_text.dart';

class MyAccordion extends StatefulWidget {
  const MyAccordion({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  State<MyAccordion> createState() => _MyAccordionState();
}

class _MyAccordionState extends State<MyAccordion> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: MyColors.line)),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          GestureDetector(
            behavior: .opaque,
            onTap: () => setState(() => isOpen = !isOpen),
            child: Container(
              constraints: BoxConstraints(minHeight: 56),
              child: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: MyText(
                      text: widget.title.toUpperCase(),
                      fontFamily: MyFonts.archivoNarrow,
                      fontWeight: .w600,
                      letterSpacing: 14 * 0.12,
                    ),
                  ),
                  Icon(
                    isOpen ? Icons.remove : Icons.add,
                    color: MyColors.white2,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (isOpen) Padding(padding: .only(bottom: 20), child: widget.child),
        ],
      ),
    );
  }
}
