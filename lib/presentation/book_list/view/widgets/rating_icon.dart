import 'package:flutter/material.dart';

class RatingIcon extends StatelessWidget {
  const RatingIcon({
    Key? key,
    required this.icon,
    required this.size,
    required this.iconColor,
    required this.rating,
    this.maxRating = 5,
  }) : super(key: key);

  final IconData icon;
  final double size;
  final Color iconColor;
  final double rating;
  final int maxRating;

  @override
  Widget build(BuildContext context) {
    var listValue = _convertToDoubleArray(rating, maxRating);
    return SizedBox(
      height: size,
      child: Row(
        children: List.generate(
          maxRating,
          (index) {
            return _shaderMask(listValue[index]);
          },
        ),
      ),
    );
  }

  List<double> _convertToDoubleArray(double value, int maxRating) {
    List<double> result = List.filled(maxRating, 0.0);
    int intValue = value.toInt();
    double decimalPart = value - intValue;

    for (int i = 0; i < intValue; i++) {
      result[i] = 1.0;
    }
    if (intValue < result.length) {
      result[intValue] = decimalPart;
    }
    return result;
  }

  Widget _shaderMask(double value) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          stops: [0, value, value],
          colors: [
            iconColor,
            iconColor,
            iconColor.withOpacity(0),
          ],
        ).createShader(rect);
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(
          icon,
          size: size,
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
