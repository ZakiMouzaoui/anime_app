import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AnimeReviewsRow extends StatelessWidget {
  const AnimeReviewsRow({super.key, required this.anime});

  final Map<String, dynamic> anime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 32,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text.rich(TextSpan(
                text: "${anime["score"] ?? 0}",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                children: const [
                  TextSpan(
                      text: "/10",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15))
                ])),
          ],
        ),
        if (anime["status"] != "Not yet aired")
          IconButton(
            style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0))),
            onPressed: () {},
            icon: Column(
              children: [
                const Icon(
                  Icons.star_border,
                  size: 32,
                ),
                SizedBox(
                  height: 8.h,
                ),
                const Text("Add a review")
              ],
            ),
          ),
        IconButton(
          style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0))),
          onPressed: () {},
          icon: Column(
            children: [
              const Icon(
                Icons.add,
                size: 32,
              ),
              SizedBox(
                height: 8.h,
              ),
              const Text("My list")
            ],
          ),
        )
      ],
    );
  }
}
