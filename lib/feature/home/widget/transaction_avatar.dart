import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/home.dart';
import 'package:wallet/feature/home/widget/widget.dart';

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
            return const Text('is Loading runing');
          } else if (state.transactionModel.isEmpty) {
            return const Text('transaction is empty');
          } else {
            return ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                //return const ShimmerWidget();
                return GestureDetector(
                  onTap: () {
                    print(list[index].secondUsername ?? 'dyar nya');
                  },
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: CircleAvatar(
                      //     radius: 30,
                      //     child: Image.asset(
                      //       // height: 20,
                      //       fit: BoxFit.contain,
                      //       'assets/img/${avatars[index]}',
                      //     ),
                      //   ),
                      // ),
                      Text(
                        list[index].secondUsername ?? 'current uid',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      //iconAvatars[index],
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
