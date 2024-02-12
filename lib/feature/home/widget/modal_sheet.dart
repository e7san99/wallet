import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet/components/components.dart';
import 'package:wallet/components/theme/theme_properties.dart';

class ModalSheet extends StatelessWidget {
  final String? username;
  final String? balance;
  final String? phone;
  final String? time;
  final String? date;
  final String? day;
  final Color? color;
  const ModalSheet({
    super.key,
    required this.username,
    required this.balance,
    required this.phone,
     required this.time,
     required this.date,
     required this.day,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Transaction Details',
              style: GoogleFonts.openSans(
                color: backgroundColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Divider(
            color: backgroundColor,
            indent: 10,
            endIndent: 10,
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name',
                          style: GoogleFonts.openSans(
                              color: Colors.black, fontSize: 16)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(username ?? '',
                          style: GoogleFonts.openSans(
                              color: color!, fontSize: 18)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Balance',
                          style: GoogleFonts.openSans(
                              color: Colors.black, fontSize: 16)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text.rich(
                        TextSpan(
                          text:
                              balance,
                          style: GoogleFonts.openSans(
                              color: color, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' IQD',
                              style: GoogleFonts.openSans(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: backgroundColor,
                indent: 10,
                endIndent: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone',
                          style: GoogleFonts.openSans(
                              color: Colors.black, fontSize: 16)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(phone??'',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Time',
                          style: GoogleFonts.openSans(
                              color: Colors.black, fontSize: 16)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(time??'',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: backgroundColor,
                indent: 10,
                endIndent: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date',
                          style: GoogleFonts.openSans(
                              color: Colors.black, fontSize: 16)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('${date??''}     ',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Day',
                          style: GoogleFonts.openSans(
                              color: Colors.black, fontSize: 16)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(day??'',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: backgroundColor,
            indent: 10,
            endIndent: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          // OwnButton(
          //   textButton: Text(
          //     'DISMISS',
          //     style: GoogleFonts.openSans(
          //       color: foregroundColor,
          //       fontSize: 20,
          //       letterSpacing: 0.3,
          //     ),
          //   ),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   backgroundColor: backgroundColor,
          //   foregroundColor: foregroundColor,
          // )
        ],
      ),
    );
  }
}
