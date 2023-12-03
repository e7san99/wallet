import 'package:flutter/material.dart';
import 'package:wallet/components/theme/theme.dart';
import 'package:wallet/screen/gridView/add_balance.dart';
import 'export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  Container divider = Container(
    margin: const EdgeInsets.all(10),
    height: 2,
    decoration: BoxDecoration(
      color: backgroundColor,
      boxShadow: List.filled(
        10,
        BoxShadow(
          blurRadius: 0.4,
          color: const Color.fromRGBO(3, 63, 116, 1).withOpacity(0.8),
        ),
      ),
    ),
    child: Divider(
      color: backgroundColor,
      indent: 10,
      endIndent: 10,
    ),
  );

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
      () {},
      () {},
      () {},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.power_settings_new,
          color: foregroundColor,
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
    );
  }
}
