import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'dart:math';

class KmCalculatorHelper {
  static const double _earthRadius = 6371; // Radius of the Earth in kilometers

  static double calculateDistance(
      {required Point? point1, required Point? point2}) {
    double lat1 = _degreesToRadians(point1?.latitude ?? 0.0);
    double lon1 = _degreesToRadians(point1?.longitude ?? 0.0);
    double lat2 = _degreesToRadians(point2?.latitude ?? 0.0);
    double lon2 = _degreesToRadians(point2?.longitude ?? 0.0);

    double dLon = lon2 - lon1;
    double dLat = lat2 - lat1;

    double a =
        pow(sin(dLat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);
    double c = 2 * asin(sqrt(a));
    double distance = _earthRadius * c;

    return double.parse(distance.toStringAsFixed(2));
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }
}
