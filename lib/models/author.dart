import 'package:firebase_auth/firebase_auth.dart';

class Massage
{
  final String error;
  final User user;

  Massage({required this.user, required this.error});

  factory Massage.fromData({required Map data}){
    return Massage(user: data["user"], error: data["error"]);
  }
}