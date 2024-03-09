import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class UserMetaDataRow extends StatelessWidget {
  const UserMetaDataRow({super.key, required this.icon, required this.info});

  final IconData icon;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: Colors.white70,),
        SizedBox(width: 4.w,),
        Text(info, style: const TextStyle(
            color: Colors.white70,
            fontSize: 14
        ), overflow: TextOverflow.ellipsis,)
      ],
    );
  }
}
