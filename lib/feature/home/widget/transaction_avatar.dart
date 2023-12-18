import 'package:wallet/feature/home/widget/widget.dart';

class TransactionAvatars extends StatelessWidget {
  const TransactionAvatars({
    super.key,
    required this.names,
    required this.avatars,
    required this.iconAvatars,
  });

  final List<String> names;
  final List<String> avatars;
  final List<Icon> iconAvatars;

  @override
  Widget build(BuildContext context) {
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
