import 'package:flutter/material.dart';

/// [SingleSelectedItem] is a selected item builder.
/// It is used to build the selected item.
class SingleSelectedItem extends StatelessWidget {
  final String label;
  const SingleSelectedItem({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
