// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? currentUid;
  String? secondUid;
  String? currentUsername;
  String? secondUsername;
  num? balance;
//  DateTime? dateTime;
  TransactionModel({
    this.currentUid,
    this.secondUid,
    this.currentUsername,
    this.secondUsername,
    this.balance,
  });

  TransactionModel copyWith({
    String? currentUid,
    String? secondUid,
    String? currentUsername,
    String? secondUsername,
    num? balance,
  }) {
    return TransactionModel(
      currentUid: currentUid ?? this.currentUid,
      secondUid: secondUid ?? this.secondUid,
      currentUsername: currentUsername ?? this.currentUsername,
      secondUsername: secondUsername ?? this.secondUsername,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentUid': currentUid,
      'secondUid': secondUid,
      'currentUsername': currentUsername,
      'secondUsername': secondUsername,
      'balance': balance,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      currentUid: map['currentUid'] != null ? map['currentUid'] as String : null,
      secondUid: map['secondUid'] != null ? map['secondUid'] as String : null,
      currentUsername: map['currentUsername'] != null ? map['currentUsername'] as String : null,
      secondUsername: map['secondUsername'] != null ? map['secondUsername'] as String : null,
      balance: map['balance'] != null ? map['balance'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(currentUid: $currentUid, secondUid: $secondUid, currentUsername: $currentUsername, secondUsername: $secondUsername, balance: $balance)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.currentUid == currentUid &&
      other.secondUid == secondUid &&
      other.currentUsername == currentUsername &&
      other.secondUsername == secondUsername &&
      other.balance == balance;
  }

  @override
  int get hashCode {
    return currentUid.hashCode ^
      secondUid.hashCode ^
      currentUsername.hashCode ^
      secondUsername.hashCode ^
      balance.hashCode;
  }

  factory TransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TransactionModel(
      currentUid: data['currentUid'], //document.id,
      secondUid: data['secondUid'],
      currentUsername: data['currentUsername'],
      secondUsername: data['secondUsername'],
      balance: data['balance'] as num,
      // dateTime: data['dateTime'],
    );
  }
  
}
