import 'package:google_fonts/google_fonts.dart';
import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/home.dart';
import 'package:wallet/feature/home/util/extention.dart';
import 'package:wallet/feature/home/util/widget/shimmer_avatar_transaction.dart';
import 'package:wallet/feature/home/widget/modal_sheet.dart';
import 'package:wallet/feature/register/cubit/cubit.dart';

class TransactionAvatars extends StatelessWidget {
  const TransactionAvatars({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          final list = state.transactionModel;
          if (state.isLoading) {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return const ShimmerWidget();
              },
              separatorBuilder: (context, index) => const SizedBox(),
              itemCount: 2,
            );
          } else if (state.transactionModel.isEmpty) {
            return Center(
              child: Text(
                'You don\'t have any transactions',
                style: GoogleFonts.openSans(
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
                        style: GoogleFonts.openSans(color: balanceColor),
                      ),
                      subtitle: Text(
                        dateFromTimeStamp.weekFormatExtension(),
                      ),
                      trailing: Text.rich(
                        TextSpan(
                          text:
                              '${sentToCurrentDevice ? '+' : '-'} ${balance.currencyFormat()}',
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
                });
          }
        },
      ),
    );
  }
}
