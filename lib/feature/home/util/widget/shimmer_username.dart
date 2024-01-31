import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallet/components/components.dart';

class ShimmerUsername extends StatelessWidget {
  const ShimmerUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade400,
          child: 
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 25,
                  width: 140, //MediaQuery.of(context).size.width / 2,
                  color: backgroundColor.withOpacity(0.2)
                ),
              ),
            
        ),
      ),
    );
  }
}
