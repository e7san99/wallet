import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/components/theme/theme.dart';
import 'package:wallet/feature/register/cubit/cubit/user_cubit.dart';

class WalletContainer extends StatelessWidget {
  const WalletContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final username = context.read<UserCubit>().state.myUser?.username;
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
                    Text(
                     'Ehsan Ahmed',//'${context.read<UserCubit>().state.myUser?.username}',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1.3,
                        fontWeight: FontWeight.w600,
                        color: foregroundColor,
                      ),
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
                    RichText(
                      text: TextSpan(
                        text: '25,000',
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
