import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/components/theme/theme.dart';
import 'package:wallet/feature/home/widget/export.dart';
import 'package:wallet/feature/home/view/add_balance.dart';
import 'package:wallet/feature/home/view/send_balance.dart';
import 'package:wallet/feature/register/cubit/cubit/user_cubit.dart';
import 'package:wallet/feature/register/view/signin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  List<String> titles = [
    'ADD BALANCE',
    'SEND',
    'WITHDRAW',
    'PAYMENT',
  ];
  List<String> iconImages = [
    'add.png',
    'send.png',
    'withdraw.png',
    'payment.png',
  ];
  List<String> avatars = [
    'boy1.png',
    'girl1.png',
    'boy2.png',
    'girl2.png',
  ];
  List<String> names = [
    'name 1',
    'name 2',
    'name 3',
    'name 4',
  ];

  List<Icon> iconAvatars = [
    const Icon(
      Icons.keyboard_double_arrow_up,
      color: Colors.green,
    ),
    const Icon(
      Icons.keyboard_double_arrow_down,
      color: Colors.red,
    ),
    const Icon(
      Icons.keyboard_double_arrow_up,
      color: Colors.green,
    ),
    const Icon(
      Icons.keyboard_double_arrow_down,
      color: Colors.red,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<void Function()?> onTap = [
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddBalancePage(),
          ),
        );
      },
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SendBalancePage(),
          ),
        );
      },
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.amber,
            content: Text(
              'Not Available',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      },
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.amber,
            content: Text(
              'Not Available',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    ];

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: BlocSelector<UserCubit, UserState, bool>(
            selector: (state) {
              return state.isLoading;
            },
            builder: (context, state) {
              return IconButton(
                onPressed: state
                    ? null
                    : () async{
                        await context.read<UserCubit>().logout();
                      },
                icon: Icon(
                  Icons.power_settings_new,
                  color: foregroundColor,
                ),
              );
            },
          ),
          title: const Text('BluePay'),
          centerTitle: true,
          elevation: 0,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.wallet),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const WalletContainer(),
              CustomeGridview(
                titles: titles,
                iconImages: iconImages,
                onTap: onTap,
              ),
              const TransactionLabels(),
              TransactionAvatars(
                  names: names, avatars: avatars, iconAvatars: iconAvatars),
            ],
          ),
        ),
      ),
    );
  }
}
