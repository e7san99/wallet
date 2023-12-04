// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Wallet {
  num? balance;
  Wallet({
    required this.balance,
  });

  Wallet copyWith({
    num? balance,
  }) {
    return Wallet(
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'balance': balance,
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      balance: map['balance'] != null ? map['balance'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Wallet.fromJson(String source) =>
      Wallet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Wallet(balance: $balance)';

  @override
  bool operator ==(covariant Wallet other) {
    if (identical(this, other)) return true;

    return other.balance == balance;
  }

  @override
  int get hashCode => balance.hashCode;
}
