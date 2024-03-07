import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'filter_option.dart';

class FilterOptionsList extends StatefulWidget {
  const FilterOptionsList(
      {super.key,
      required this.title,
      required this.options,
      required this.selectedOptions,
      this.isDropdown = false, this.width, this.isOpen=true});

  final String title;
  final bool isDropdown;
  final bool isOpen;
  final Map<String, dynamic> options;
  final List selectedOptions;
  final double? width;

  @override
  State<FilterOptionsList> createState() => _FilterOptionsListState();
}

class _FilterOptionsListState extends State<FilterOptionsList> {
  late bool showOptions = widget.isOpen;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (widget.isDropdown)
          SizedBox(
            height: 38.h,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white24)),
                onPressed: () {
                  setState(() {
                    showOptions = !showOptions;
                  });
                },
                child: Row(
                  children: [
                    !showOptions
                        ? const Icon(Icons.keyboard_arrow_down_rounded)
                        : const Icon(Icons.keyboard_arrow_up_rounded),
                    const Spacer(),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer()
                  ],
                )),
          )
        else
          Center(child: Text(widget.title)),
        SizedBox(height: 12.h),
        if (showOptions)
          Padding(
            padding: widget.isDropdown ? EdgeInsets.only(bottom: 16.h) : EdgeInsets.zero,
            child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: widget.options.entries
                    .map((e) => FilterOption(
                        width: widget.width,
                        value: e.key,
                        selectedOptions: widget.selectedOptions,
                        title: e.value))
                    .toList()),
          ),
      ]
    );
  }
}
