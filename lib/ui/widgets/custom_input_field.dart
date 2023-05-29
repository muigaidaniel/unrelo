import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {super.key,
      required this.label,
      required this.controller,
      this.keybordType});
  final String label;
  final TextInputType? keybordType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: TextFormField(
        keyboardType: keybordType,
        controller: controller,
        style: Theme.of(context).textTheme.bodyMedium,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          label: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white, width: 1),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        // decoration: InputDecoration(
        //     label: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        //     enabledBorder: const OutlineInputBorder(
        //       borderSide: BorderSide(color: Colors.white, width: 2),
        //     ),
        //     focusedBorder: const OutlineInputBorder(
        //       borderSide: BorderSide(color: Colors.white, width: 2),
        //     ),
        //     border: const OutlineInputBorder(
        //       borderSide: BorderSide(color: Colors.white),
        //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //     )),
      ),
    );
  }
}
