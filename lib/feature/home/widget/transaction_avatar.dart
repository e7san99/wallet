import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/home.dart';
import 'package:wallet/feature/home/util/extention.dart';
import 'package:wallet/feature/register/cubit/cubit.dart';

class TransactionAvatars extends StatelessWidget {
  const TransactionAvatars({
    super.key,
    required this.avatars,
    required this.iconAvatars,
  });

  final List<String> avatars;
  final List<Icon> iconAvatars;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          final list = state.transactionModel;
          if (state.isLoading) {
            return SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const ShimmerWidget();
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 5,
              ),
            );
          } else if (state.transactionModel.isEmpty) {
            return Center(
              child: Text(
                'You don\'t have any transactions',
                style: TextStyle(
                    fontFamily: 'handlee',
                    color: backgroundColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            );
          } else {
          list.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: list.length > 2 ? 2 : list.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var balance = list[index].balance;

                  bool sentToCurrentDevice = list[index].secondUid ==
                      FirebaseAuth.instance.currentUser?.uid;
                  Color balanceColor =
                      sentToCurrentDevice ? backgroundColor : Colors.red;

                  var dateFromTimeStamp = DateTime.fromMillisecondsSinceEpoch(
                      list[index].dateTime!.millisecondsSinceEpoch);

                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100]?.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Icon(
                        sentToCurrentDevice
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                        color: balanceColor,
                      ),
                      title: Text(
                        '${sentToCurrentDevice ? list[index].currentUsername : list[index].secondUsername}',
                        style: TextStyle(color: balanceColor),
                      ),
                      subtitle: Text(
                        dateFromTimeStamp.dateFormatExtention(),
                      ),
                      trailing: Text.rich(
                        TextSpan(
                          text:
                              '${sentToCurrentDevice ? '+' : '-'} ${balance.currencyFormat()}',
                          style: TextStyle(color: balanceColor, fontSize: 15),
                          children: const <TextSpan>[
                            TextSpan(
                              text: ' IQD',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
            // ListView.separated(
            //   shrinkWrap: true,
            //   scrollDirection: Axis.horizontal,
            //   itemBuilder: (context, index) {
            //     bool sentToCurrentDevice = list[index].secondUid ==
            //         FirebaseAuth.instance.currentUser?.uid;
            //     Color balanceColor =
            //         sentToCurrentDevice ? Colors.green : Colors.red;

            //     return GestureDetector(
            //       onTap: () {
            //         print(list[index].secondUsername ?? 'default username');
            //       },
            //       child: Column(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: CircleAvatar(
            //               radius: 30,
            //               backgroundColor: balanceColor,
            //               child: Text(list[index].balance.toString()),
            //             ),
            //           ),
            //           Text(
            //             '${sentToCurrentDevice ? list[index].currentUsername : list[index].secondUsername}',
            //             style: const TextStyle(
            //               color: Colors.black,
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            //   separatorBuilder: (context, index) => const Divider(),
            //   itemCount: list.length,
            // );
          }
        },
      ),
    );
  }
}
