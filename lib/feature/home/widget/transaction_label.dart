import 'package:flutter/material.dart';
import 'package:wallet/components/theme/theme.dart';
import 'package:wallet/feature/home/view/view_all.dart';

class TransactionLabels extends StatelessWidget {
  const TransactionLabels({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Transactions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ViewAll(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                children: [
                  Text(
                    'VIEW ALL',
                    style: TextStyle(
                      fontSize: 14,
                      color: backgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: backgroundColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
