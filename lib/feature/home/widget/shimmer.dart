import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade400,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //buildAvatar(),
              const SizedBox(
                width: 10,
              ),
              buildTextEffect(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAvatar() => CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        radius: 30,
      );

  Widget buildTextEffect(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildAvatar(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: 10,
              width: 80, //MediaQuery.of(context).size.width / 2,
              color: Colors.grey.shade300,
            ),
          ),
        ],
      );
}
