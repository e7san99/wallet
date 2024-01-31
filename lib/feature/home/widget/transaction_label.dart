import 'package:wallet/feature/home/view/transactions.dart';
import 'package:wallet/feature/home/view/view.dart';

class TransactionLabels extends StatelessWidget {
  const TransactionLabels({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 30, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Last Transactions',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransactionsView(),
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
