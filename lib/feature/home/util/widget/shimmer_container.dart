import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallet/components/theme/theme_properties.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Shimmer.fromColors(
          baseColor: backgroundColor,
          highlightColor: const Color(0xFF64B5F6),
          child: Container(
              height: 150,
              // width: 140, //MediaQuery.of(context).size.width / 2,
              color: backgroundColor),
        ),
      ),
    );
  }
}
