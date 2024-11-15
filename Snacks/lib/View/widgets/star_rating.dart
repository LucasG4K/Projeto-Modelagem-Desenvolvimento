import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final double tamanho;
  final RatingChangeCallback? onRatingChanged;

  const StarRating({super.key,this.starCount = 5, this.rating = .0, this.onRatingChanged,this.tamanho=18});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: Colors.amber,
        size: tamanho
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: Colors.amber,
        size: tamanho
      );
    } else {
      icon = Icon(
        Icons.star,
        color:Colors.amber,
        size: tamanho
      );
    }
    return InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: List.generate(starCount, (index) => buildStar(context, index)));
  }
}