import 'package:google_fonts/google_fonts.dart';
import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/util/extention.dart';
import 'package:wallet/feature/home/util/widget/shimmer_container.dart';
import 'package:wallet/feature/home/util/widget/shimmer_short_text.dart';
import 'package:wallet/feature/home/widget/widget.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

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
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state.myUser == null) {
          return const ShimmerContainer();
        } else {
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextAnimator(
                                state.myUser!.username!,
                                incomingEffect:
                                    WidgetTransitionEffects.incomingScaleDown(),
                                atRestEffect: WidgetRestingEffects.none(),
                                style: GoogleFonts.openSans(
                                  fontSize: 20,
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.w600,
                                  color: foregroundColor,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextAnimator(
                                context.read<UserCubit>().state.myUser!.phone!,
                                incomingEffect:
                                    WidgetTransitionEffects.incomingScaleDown(),
                                atRestEffect: WidgetRestingEffects.none(),
                                style: GoogleFonts.openSans(
                                  fontSize: 15,
                                  letterSpacing: 1.3,
                                  fontWeight: FontWeight.w600,
                                  color: foregroundColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Balance: ',
                              style: GoogleFonts.openSans(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          BlocSelector<WalletCubit, WalletState, num?>(
                            selector: (state) {
                              return state.wallet?.balance;
                            },
                            builder: (context, balance) {
                              if (balance == null) {
                                return const Text('');
                              } else {
                                return TextAnimator(
                                  balance.currencyFormat(),
                                  incomingEffect: WidgetTransitionEffects
                                      .incomingScaleDown(),
                                  atRestEffect: WidgetRestingEffects.none(),
                                  style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    height: 0.9,
                                  ),
                                );
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              ' IQD',
                              style: GoogleFonts.openSans(
                                  fontSize: 10, color: foregroundColor),
                            ),
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
      },
    );
  }
}
