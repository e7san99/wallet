import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/home.dart';
import 'package:wallet/feature/home/widget/widget.dart';
import 'package:wallet/feature/register/cubit/cubit.dart';

class TransactionAvatars extends StatelessWidget {
  const TransactionAvatars({
    Key? key,
    required this.avatars,
    required this.iconAvatars,
  }) : super(key: key);

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
            return const Text('is Loading running');
          } else if (state.transactionModel.isEmpty) {
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
          } else {
            return ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {

                bool sentToCurrentDevice = list[index].secondUid == FirebaseAuth.instance.currentUser?.uid;
                Color balanceColor = sentToCurrentDevice ? Colors.green : Colors.red ;

                return GestureDetector(
                  onTap: () {
                    print(list[index].secondUsername ?? 'default username');
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: balanceColor,
                          child: Text(list[index].balance.toString()),
                        ),
                      ),
                      Text(
                        '${sentToCurrentDevice? list[index].currentUsername : list[index].secondUsername}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: list.length,
            );
          }
        },
      ),
    );
  }
}
