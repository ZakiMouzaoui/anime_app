import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';

class KHelperFunctions {
  static String calculateAvgRating(Map<String, dynamic> ratingFrequencies) {
    double totalRatings = 0;
    double totalPoints = 0;

    ratingFrequencies.forEach((rating, frequency) {
      double ratingValue = double.parse(rating);
      double frequencyValue = double.parse(frequency);

      totalRatings += frequencyValue;
      totalPoints += ratingValue * frequencyValue;
    });

    double avgRating = totalPoints / totalRatings;
    double scaledRating = (avgRating / 20.0) * 10.0;

    return scaledRating.toStringAsFixed(2);
  }

  static String getAnimeStatus(String status) {
    switch (status) {
      case 'Finished Airing':
        return "finished";
      case 'Currently Airing':
        return 'airing';
      case 'Not yet aired':
        return 'upcoming';
      default:
        return '';
    }
  }

  static String getSeason(DateTime date) {
    int dayOfYear = date.difference(DateTime(date.year)).inDays + 1;

    if (dayOfYear >= 80 && dayOfYear <= 171) {
      return 'Spring ${date.year}';
    } else if (dayOfYear >= 172 && dayOfYear <= 263) {
      return 'Summer ${date.year}';
    } else if (dayOfYear >= 264 && dayOfYear <= 355) {
      return 'Fall ${date.year}';
    } else {
      return 'Winter ${date.year}';
    }
  }

  static void saveImage(String url) async {
    try {
      final isSaved = await GallerySaver.saveImage(url);
      if (isSaved != null) {
        Fluttertoast.showToast(msg: "Image saved");
        return;
      }
    } on PlatformException catch (_) {
      //TODO
    }
  }
}
