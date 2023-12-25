import 'model.dart';

class MyUser {
  String? uid;
  String? username;
  String? phone;
  String? email;
  MyUser({
    this.uid,
    this.username,
    this.phone,
    this.email,
  });

  MyUser copyWith({
    String? uid,
    String? username,
    String? phone,
    String? email,
  }) {
    return MyUser(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'phone': phone,
      'email': email,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      uid: map['uid'] != null ? map['uid'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) =>
      MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyUser(uid: $uid, username: $username, phone: $phone, email: $email)';
  }

  @override
  bool operator ==(covariant MyUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.username == username &&
      other.phone == phone &&
      other.email == email;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      username.hashCode ^
      phone.hashCode ^
      email.hashCode ;
  }

  factory MyUser.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return MyUser(
      uid: document.id,
      username: data['username'],
      phone: data['phone'],
      email: data['email'],
    );
  }
}
