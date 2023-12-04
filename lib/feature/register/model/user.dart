import 'dart:convert';
import 'package:wallet/feature/home/model/wallet.dart';

class MyUser {
  String? username;
  String? phone;
  Wallet? wallet;
  MyUser({
    required this.username,
    required this.phone,
    required this.wallet,
  });

  MyUser copyWith({
    String? username,
    String? phone,
    Wallet? wallet,
  }) {
    return MyUser(
      username: username ?? this.username,
      phone: phone ?? this.phone,
      wallet: wallet ?? this.wallet,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'phone': phone,
      'wallet': wallet?.toMap(),
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      username: map['username'] != null ? map['username'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      wallet: map['wallet'] != null ? Wallet.fromMap(map['wallet'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MyUser(username: $username, phone: $phone, wallet: $wallet)';

  @override
  bool operator ==(covariant MyUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username &&
      other.phone == phone &&
      other.wallet == wallet;
  }

  @override
  int get hashCode => username.hashCode ^ phone.hashCode ^ wallet.hashCode;
}
