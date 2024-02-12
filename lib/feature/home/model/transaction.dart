// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? currentUid;
  String? secondUid;
  String? currentUsername;
  String? secondUsername;
  String? currentphoneNumber;
  String? secondphoneNumber;
  num? balance;
  DateTime? dateTime;
  TransactionModel({
    this.currentUid,
    this.secondUid,
    this.currentUsername,
    this.secondUsername,
    this.currentphoneNumber,
    this.secondphoneNumber,
    this.balance,
    this.dateTime,
  });

  TransactionModel copyWith({
    String? currentUid,
    String? secondUid,
    String? currentUsername,
    String? secondUsername,
    String? currentphoneNumber,
    String? secondphoneNumber,
    num? balance,
    DateTime? dateTime,
  }) {
    return TransactionModel(
      currentUid: currentUid ?? this.currentUid,
      secondUid: secondUid ?? this.secondUid,
      currentUsername: currentUsername ?? this.currentUsername,
      secondUsername: secondUsername ?? this.secondUsername,
      currentphoneNumber: currentphoneNumber ?? this.currentphoneNumber,
      secondphoneNumber: secondphoneNumber ?? this.secondphoneNumber,
      balance: balance ?? this.balance,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentUid': currentUid,
      'secondUid': secondUid,
      'currentUsername': currentUsername,
      'secondUsername': secondUsername,
      'currentphoneNumber': currentphoneNumber,
      'secondphoneNumber': secondphoneNumber,
      'balance': balance,
      'dateTime': dateTime?.millisecondsSinceEpoch,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      currentUid: map['currentUid'] != null ? map['currentUid'] as String : null,
      secondUid: map['secondUid'] != null ? map['secondUid'] as String : null,
      currentUsername: map['currentUsername'] != null ? map['currentUsername'] as String : null,
      secondUsername: map['secondUsername'] != null ? map['secondUsername'] as String : null,
      currentphoneNumber: map['currentphoneNumber'] != null ? map['currentphoneNumber'] as String : null,
      secondphoneNumber: map['secondphoneNumber'] != null ? map['secondphoneNumber'] as String : null,
      balance: map['balance'] != null ? map['balance'] as num : null,
      dateTime: map['dateTime'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(currentUid: $currentUid, secondUid: $secondUid, currentUsername: $currentUsername, secondUsername: $secondUsername, currentphoneNumber: $currentphoneNumber, secondphoneNumber: $secondphoneNumber, balance: $balance, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.currentUid == currentUid &&
      other.secondUid == secondUid &&
      other.currentUsername == currentUsername &&
      other.secondUsername == secondUsername &&
      other.currentphoneNumber == currentphoneNumber &&
      other.secondphoneNumber == secondphoneNumber &&
      other.balance == balance &&
      other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return currentUid.hashCode ^
      secondUid.hashCode ^
      currentUsername.hashCode ^
      secondUsername.hashCode ^
      currentphoneNumber.hashCode ^
      secondphoneNumber.hashCode ^
      balance.hashCode ^
      dateTime.hashCode;
  }

  factory TransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TransactionModel(
      currentUid: data['currentUid'], //document.id,
      secondUid: data['secondUid'],
      currentUsername: data['currentUsername'],
      secondUsername: data['secondUsername'],
      currentphoneNumber: data['currentphoneNumber'],
      secondphoneNumber: data['secondphoneNumber'],
      balance: data['balance'] as num,
      dateTime: data['dateTime'] != null
          ? (data['dateTime'] as Timestamp).toDate()
          : null,
    );
  }
}
