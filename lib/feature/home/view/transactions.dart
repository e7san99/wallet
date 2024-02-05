import 'package:flutter/material.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:wallet/components/components.dart';
import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/util/extention.dart';
import 'package:wallet/feature/register/cubit/cubit.dart';

class TransactionsView extends StatefulWidget {
  const TransactionsView({super.key});

  @override
  State<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  int switcherIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            SlideSwitcher(
              containerColor: backgroundColor,
              onSelect: (int index) => setState(() => switcherIndex = index),
              containerHeight: 40,
              containerWight: 220,
              children: [
                Text(
                  'All',
                  style: TextStyle(
                    fontWeight:
                        switcherIndex == 0 ? FontWeight.w500 : FontWeight.w400,
                    color: switcherIndex == 0 ? backgroundColor : Colors.white,
                  ),
                ),
                Text(
                  'Sent',
                  style: TextStyle(
                    fontWeight:
                        switcherIndex == 1 ? FontWeight.w500 : FontWeight.w400,
                    color: switcherIndex == 1 ? backgroundColor : Colors.white,
                  ),
                ),
                Text(
                  'Received',
                  style: TextStyle(
                    fontWeight:
                        switcherIndex == 2 ? FontWeight.w500 : FontWeight.w400,
                    color: switcherIndex == 2 ? backgroundColor : Colors.white,
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                SizedBox(width: 65),
              ],
            ),
            BlocBuilder<WalletCubit, WalletState>(
              builder: (context, state) {
                final list = state.transactionModel;
                if (state.isLoading) {
                  return SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return const ShimmerWidget();
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: 5,
                    ),
                  );
                } else if (state.transactionModel.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 200,
                        ),
                        Text(
                          'You don\'t have any transactions',
                          style: TextStyle(
                              fontFamily: 'handlee',
                              color: backgroundColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          'assets/img/empty.png',
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(30),
                      itemCount: list.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var balance = list[index].balance;
                        // final usCurrency = NumberFormat('#,##0', 'en_US');
                        bool sentToCurrentDevice = list[index].secondUid ==
                            FirebaseAuth.instance.currentUser?.uid;
                        Color balanceColor =
                            sentToCurrentDevice ? backgroundColor : Colors.red;
                        var dateFromTimeStamp =
                            DateTime.fromMillisecondsSinceEpoch(
                                list[index].dateTime!.millisecondsSinceEpoch);

                        // Check if the transaction is sent
                        if (!sentToCurrentDevice && switcherIndex != 2) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.blue[100]?.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.arrow_downward_rounded,
                                color: balanceColor,
                              ),
                              title: Text(
                                '${list[index].secondUsername}',
                                style: TextStyle(color: balanceColor),
                              ),
                              subtitle: Text(
                                dateFromTimeStamp.dateFormatExtention(),
                              ),
                              trailing: Text.rich(
                                TextSpan(
                                  text: '- ${balance.currencyFormat()}',
                                  style: TextStyle(
                                      color: balanceColor, fontSize: 15),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: ' IQD',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if (sentToCurrentDevice && switcherIndex != 1) {
                          // Check if the transaction is received
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.blue[100]?.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.arrow_upward_rounded,
                                color: balanceColor,
                              ),
                              title: Text(
                                '${list[index].currentUsername}',
                                style: TextStyle(color: balanceColor),
                              ),
                              subtitle: Text(
                                dateFromTimeStamp.dateFormatExtention(),
                              ),
                              trailing: Text.rich(
                                TextSpan(
                                  text: '+ ${balance.currencyFormat()}',
                                  style: TextStyle(
                                      color: balanceColor, fontSize: 15),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: ' IQD',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Return an empty container for other cases
                          return Container();
                        }
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
