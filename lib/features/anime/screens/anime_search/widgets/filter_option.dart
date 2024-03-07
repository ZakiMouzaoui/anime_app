import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../utils/constants/colors.dart';

class FilterOption extends StatelessWidget {
  const FilterOption(
      {super.key,
      required this.value,
      required this.selectedOptions,
      required this.title, this.width});

  final String value;
  final String title;
  final List selectedOptions;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        constraints: BoxConstraints(
          minWidth: 50.w
        ),
        width: width,
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: selectedOptions.contains(value)
              ? Colors.blue.shade600
              : KColors.darkContainer,
          child: InkWell(
            onTap: () {
              if (selectedOptions.contains(value)) {
                selectedOptions.remove(value);
              } else {
                selectedOptions.add(value);
              }
            },
            borderRadius: BorderRadius.circular(15),
            child: Container(
              constraints: BoxConstraints(
                minWidth: 30.w
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              color: Colors.transparent,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
