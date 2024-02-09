import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.blue[100]!.withOpacity(0.6),
          child: Column(
            children: [
              Container(
                height: 150,
                // width: 140, //MediaQuery.of(context).size.width / 2,
                color: Colors.blue[300]!.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
