import 'package:flutter/material.dart';

class Collapsible extends StatefulWidget {
  final String title;
  final Widget child;

  const Collapsible({super.key, required this.title, required this.child});

  @override
  State<Collapsible> createState() => _CollapsibleState();
}

class _CollapsibleState extends State<Collapsible> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleExpanded,
          child: Row(
            children: [
              Icon(_isExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right),
              Text(widget.title)
            ],
          ),
        ),
        if (_isExpanded) widget.child,
      ],
    );
  }
}
