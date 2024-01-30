import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/repository/util/extention.dart';
import 'package:wallet/feature/home/repository/util/shimmer_username.dart';
import 'package:wallet/feature/home/widget/widget.dart';

class WalletContainer extends StatefulWidget {
  const WalletContainer({
    super.key,
  });

  @override
  State<WalletContainer> createState() => _WalletContainerState();
}

class _WalletContainerState extends State<WalletContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 150,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: foregroundColor,
                      radius: 25,
                      child: const Icon(
                        Icons.person_outline_outlined,
                        size: 50,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    BlocSelector<UserCubit, UserState, String?>(
                      selector: (state) {
                        return state.myUser?.username;
                      },
                      builder: (context, username) {
                        if (username == null) {
                          return const ShimmerUsername();
                        } else {
                          return Text(
                            username,
                            style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 1.3,
                              fontWeight: FontWeight.w600,
                              color: foregroundColor,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Balance: ',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    BlocSelector<WalletCubit, WalletState, num?>(
                      selector: (state) {
                        return state.wallet?.balance;
                      },
                      
                      builder: (context, balance) {
                        return RichText(
                          text: TextSpan(
                            text:balance?.currencyFormat(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              height: 0.9,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' IQD',
                                  style: TextStyle(
                                      fontSize: 10, color: foregroundColor)),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
