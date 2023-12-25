// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Wallet {
  String? uid;
  num? balance;
  Wallet({
    this.uid,
    this.balance,
  });

  Wallet copyWith({
    String? uid,
    num? balance,
  }) {
    return Wallet(
      uid: uid ?? this.uid,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'balance': balance,
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      uid: map['uid'] != null ? map['uid'] as String : null,
      balance: map['balance'] != null ? map['balance'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Wallet.fromJson(String source) =>
      Wallet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Wallet(uid: $uid, balance: $balance)';

  @override
  bool operator ==(covariant Wallet other) {
    if (identical(this, other)) return true;

    return other.uid == uid && other.balance == balance;
  }

  @override
  int get hashCode => uid.hashCode ^ balance.hashCode;

  factory Wallet.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Wallet(
      uid: document.id,
      balance: data['balance'] as num,
    );
  }
}
