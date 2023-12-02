import 'package:flutter/material.dart';
import 'package:wallet/components/reusable/shimmer.dart';
import 'package:wallet/components/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> titles = [
    'ADD MONEY',
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
    return Scaffold(
      //backgroundColor: Colors.grey[800],
      appBar: AppBar(
        leading: const Icon(Icons.more_horiz),
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
            walletContainer(),
            gridView(),
            textTransaction(),
            userTransaction(),
          ],
        ),
      ),
    );
  }

  Padding walletContainer() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 25),
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
                      'Ehsan Ahmed',
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

  GridView gridView() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 4,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 25),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 100,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print(titles[index]);
          },
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  titles[index],
                  style: TextStyle(
                    color: foregroundColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Image.asset(
                  height: 50,
                  fit: BoxFit.fill,
                  'assets/img/${iconImages[index]}',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Padding textTransaction() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Transactions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                children: [
                  Text(
                    'VIEW ALL',
                    style: TextStyle(
                      fontSize: 14,
                      color: backgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: backgroundColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox userTransaction() {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          //return const ShimmerWidget();
          return GestureDetector(
            onTap: () {
              print(names[index]);
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 30,
                    child: Image.asset(
                      // height: 20,
                      fit: BoxFit.contain,
                      'assets/img/${avatars[index]}',
                    ),
                  ),
                ),
                Text(
                  names[index],
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                iconAvatars[index],
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: avatars.length,
      ),
    );
  }
}
