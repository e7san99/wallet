import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:wallet/components/components.dart';
import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/util/extention.dart';
import 'package:wallet/feature/home/util/widget/shimmer_avatar_transaction.dart';
import 'package:wallet/feature/home/widget/modal_sheet.dart';
import 'package:wallet/feature/register/cubit/cubit.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
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
                  style: GoogleFonts.openSans(
                    fontWeight:
                        switcherIndex == 0 ? FontWeight.w500 : FontWeight.w400,
                    color: switcherIndex == 0 ? backgroundColor : Colors.white,
                  ),
                ),
                Text(
                  'Sent',
                  style: GoogleFonts.openSans(
                    fontWeight:
                        switcherIndex == 1 ? FontWeight.w500 : FontWeight.w400,
                    color: switcherIndex == 1 ? backgroundColor : Colors.white,
                  ),
                ),
                Text(
                  'Received',
                  style: GoogleFonts.openSans(
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
                          style: GoogleFonts.openSans(
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
                  list.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
                  return Expanded(
                    child: TransformableListView.builder(
                      getTransformMatrix: getTransformMatrix,
                      padding: const EdgeInsets.all(10),
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
                                style:
                                    GoogleFonts.openSans(color: balanceColor),
                              ),
                              subtitle: Text(
                                dateFromTimeStamp.weekFormatExtension(),
                              ),
                              trailing: Text.rich(
                                TextSpan(
                                  text: '- ${balance.currencyFormat()}',
                                  style: GoogleFonts.openSans(
                                      color: balanceColor, fontSize: 15),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' IQD',
                                      style: GoogleFonts.openSans(
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
                                style:
                                    GoogleFonts.openSans(color: balanceColor),
                              ),
                              subtitle: Text(
                                dateFromTimeStamp.weekFormatExtension(),
                              ),
                              trailing: Text.rich(
                                TextSpan(
                                  text: '+ ${balance.currencyFormat()}',
                                  style: GoogleFonts.openSans(
                                      color: balanceColor, fontSize: 15),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' IQD',
                                      style: GoogleFonts.openSans(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                                        showModalBottomSheet(
                          // isScrollControlled: true, //barzayykayzor abe
                          enableDrag: true,
                          showDragHandle: true,
                          isDismissible: true,
                          useRootNavigator: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          useSafeArea: true,
                          context: context,
                          builder: (context) {
                            return ModalSheet(
                              username:
                                  '${sentToCurrentDevice ? list[index].currentUsername : list[index].secondUsername}',
                              phone:
                                  '${sentToCurrentDevice ? list[index].currentphoneNumber : list[index].secondphoneNumber}',
                              balance:
                                  '${sentToCurrentDevice ? '+' : '-'} ${balance.currencyFormat()}',
                              color: balanceColor,
                              time: dateFromTimeStamp.timeFormatExtension(),
                              date: dateFromTimeStamp.dateFormatExtension(),
                              day: dateFromTimeStamp
                                  .nameOfTheDayFormatExtension(),
                            );
                          },
                        );
                              },
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

  Matrix4 getTransformMatrix(TransformableListItem item) {
    /// final scale of child when the animation is completed
    const endScaleBound = 0.3;

    /// 0 when animation completed and [scale] == [endScaleBound]
    /// 1 when animation starts and [scale] == 1
    final animationProgress = item.visibleExtent / item.size.height;

    /// result matrix
    final paintTransform = Matrix4.identity();

    /// animate only if item is on edge
    if (item.position != TransformableListItemPosition.middle) {
      final scale = endScaleBound + ((1 - endScaleBound) * animationProgress);

      paintTransform
        ..translate(item.size.width / 2)
        ..scale(scale)
        ..translate(-item.size.width / 2);
    }

    return paintTransform;
  }
}
