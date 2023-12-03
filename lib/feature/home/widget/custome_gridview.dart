import 'package:flutter/material.dart';
import 'package:wallet/components/theme/theme.dart';

class CustomeGridview extends StatelessWidget {
  const CustomeGridview({
    super.key,
    required this.titles,
    required this.iconImages,
    required this.onTap,
  });

  final List<String> titles;
  final List<String> iconImages;
  final List<Function()?> onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: titles.length,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 25),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 100,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: onTap[index],
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  titles[index],
                  style: TextStyle(
                    color: foregroundColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Image.asset(
                  height: 50,
                  fit: BoxFit.fill,
                  'assets/img/${iconImages[index]}',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
