import 'package:flutter/material.dart';
import 'package:wallet/feature/home/home.dart';

class ViewAll extends StatefulWidget {
  const ViewAll({super.key});

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  // // List<String> avatars = [
  // //   'boy1.png',
  // //   'girl1.png',
  // //   'boy2.png',
  // //   'girl2.png',
  // //   'boy1.png',
  // //   'girl1.png',
  // //   'boy2.png',
  // //   'girl2.png',
  // //   'boy1.png',
  // //   'girl1.png',
  // //   'boy2.png',
  // //   'girl2.png',
  // // ];
  // // List<String> names = [
  // //   'name 1',
  // //   'name 2',
  // //   'name 3',
  // //   'name 4',
  // //   'name 1',
  // //   'name 2',
  // //   'name 3',
  // //   'name 4',
  // //   'name 1',
  // //   'name 2',
  // //   'name 3',
  // //   'name 4',
  // // ];
  // // List<Icon> iconAvatars = [
  // //   const Icon(
  // //     Icons.keyboard_double_arrow_up,
  // //     color: Colors.green,
  // //   ),
  // //   const Icon(
  // //     Icons.keyboard_double_arrow_down,
  // //     color: Colors.red,
  // //   ),
  // //   const Icon(
  // //     Icons.keyboard_double_arrow_up,
  // //     color: Colors.green,
  // //   ),
  // //   const Icon(
  // //     Icons.keyboard_double_arrow_down,
  // //     color: Colors.red,
  // //   ),
  // //   const Icon(
  // //     Icons.keyboard_double_arrow_up,
  // //     color: Colors.green,
  // //   ),
  // //   const Icon(
  // //     Icons.keyboard_double_arrow_down,
  // //     color: Colors.red,
  // //   ),
  // //   const Icon(
  // //     Icons.keyboard_double_arrow_up,
  // //     color: Colors.green,
  // //   ),
  // //   const Icon(
  // //     Icons.keyboard_double_arrow_down,
  // //     color: Colors.red,
  // //   ),
  // //   const Icon(
  // //     Icons.keyboard_double_arrow_up,
  // //     color: Colors.green,
  // //   ),
  // //   const Icon(
  // //     Icons.keyboard_double_arrow_down,
  // //     color: Colors.red,
  // //   ),
  // //   const Icon(
  // //     Icons.keyboard_double_arrow_up,
  // //     color: Colors.green,
  // //   ),
  // //   const Icon(
  // //     Icons.keyboard_double_arrow_down,
  // //     color: Colors.red,
  // //   ),
  // // ];

  // @override
  // void initState() {
  //   context.read<UserCubit>().getListOfUserData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final listOfMyUser = context.read<UserCubit>().state.listOfmyUser;
    // final username = context.read<UserCubit>().state.myUser?.username;
    return Scaffold(
        appBar: AppBar(
          title: const Text('View All'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: listOfMyUser?.length,
            itemBuilder: (context, index) {
              return ListTile(
                isThreeLine: false,
                onTap: () {},
                // leading: CircleAvatar(
                //   radius: 30,
                //   child: Image.asset(
                //     // height: 20,
                //     fit: BoxFit.contain,
                //     'assets/img/${listOfMyUser[index]}',
                //   ),
                // ),
                title: Text(listOfMyUser?[index]?.username?? 'NoNe'),
               // trailing: iconAvatars[index],
                subtitle: const Text('20,000'),
              );
            },
          ),
        ));
  }
}
/*
 Icon(
                Icons.keyboard_double_arrow_up,
                color: Colors.green,
              ),
*/