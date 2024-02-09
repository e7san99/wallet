import 'package:google_fonts/google_fonts.dart';
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
          Text(
            'Last Two Transactions',
            style: GoogleFonts.roboto(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 85, 150),
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
                    style: GoogleFonts.roboto(
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
