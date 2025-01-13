import 'package:flutter/material.dart';

class Chip_Component extends StatelessWidget {
  const Chip_Component({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: Colors.brown.shade900,
          fontSize: 14,
        ),
      ),
      backgroundColor: Colors.orange.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
