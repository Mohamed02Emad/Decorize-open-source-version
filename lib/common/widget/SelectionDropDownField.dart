import 'package:decorizer/common/common.dart';
import 'package:flutter/material.dart';

import '../constant/textStyles.dart';

class SelectionDropDownField extends StatefulWidget {
  final String label;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const SelectionDropDownField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    required this.controller,
  });

  @override
  State<SelectionDropDownField> createState() => _SelectionDropDownFieldState();
}

class _SelectionDropDownFieldState extends State<SelectionDropDownField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          textAlign: TextAlign.start,
          style: TextStyles.regular16(),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButton<String>(
            value:
                widget.controller.text.isEmpty ? null : widget.controller.text,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            underline: const SizedBox(),
            dropdownColor: context.appColors.background,
            items: widget.items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyles.regular15(),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                widget.controller.text = newValue!;
              });
              /**
               * null here
               */
              widget.onChanged(newValue!);
            },
          ),
        ),
      ],
    );
  }
}
