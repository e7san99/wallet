import 'package:flutter/material.dart';
import 'package:wallet/components/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        leading: const Icon(Icons.more_horiz),
        title: const Text('My Wallet'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 150,
              width: double.infinity,
              color: backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.s,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 25,
                            child: Icon(
                              Icons.person_outline_outlined,
                              size: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Ehsan Ahmed',
                            style:
                                TextStyle(fontSize: 18, color: foregroundColor),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Balance: ',
                            style: TextStyle(fontSize: 18),
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
                  DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.blueGrey),
                    child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Add Money',
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),
            ),
          ),
          const Text('data'),
        ],
      ),
    );
  }
}
