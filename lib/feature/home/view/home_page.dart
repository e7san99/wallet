import 'package:wallet/feature/home/cubit/wallet_cubit.dart';
import 'package:wallet/feature/home/home.dart';
import 'package:wallet/feature/register/register.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserData();
    context.read<UserCubit>().getListOfUserData();
    context.read<WalletCubit>().getWallet();
    context.read<WalletCubit>().getTransaction();
  }

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

    return BlocListener<UserCubit, UserState>(
      listenWhen: (previous, current) => previous.myUser != current.myUser,
      listener: (context, state) {
        if (state.myUser == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SigninPage(),
            ),
          );
        }
      },
      child: Form(
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
                      : () async {
                          await context.read<UserCubit>().logout();
                        },
                  icon: Icon(
                    Icons.power_settings_new,
                    color: foregroundColor,
                  ),
                );
              },
            ),
            title: const Text('FlexPay'),
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
                TransactionAvatars(avatars: avatars, iconAvatars: iconAvatars),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
