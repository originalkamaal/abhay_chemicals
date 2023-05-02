import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddNewPalti extends StatefulWidget {
  final String palti;
  final int temperature;
  final String notes;
  final String date;
  const AddNewPalti(
      {super.key,
      required this.palti,
      required this.temperature,
      required this.notes,
      required this.date});

  @override
  State<AddNewPalti> createState() => _AddNewPaltiState();
}

class _AddNewPaltiState extends State<AddNewPalti> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
