import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Bitesy/constants/constants.dart';
import 'package:Bitesy/features/login_and_signup/data/model/user.dart';

final FirebaseFirestore _firestore = Constants.firestore;
final CollectionReference _users = _firestore.collection('users');

class ResponseUser {
  int status;
  String message;
  UserModel user;
  ResponseUser({this.status = 0, this.message = "", required this.user});
  int get getStatus => status;
  String get getMessage => message;
}

class UserRepository {
  static Future<ResponseUser> addUser(UserModel user) async {
    ResponseUser response = ResponseUser(user: user);

    DocumentReference documentReference = _users.doc(FirebaseAuth.instance.currentUser!.uid);

    await documentReference.set(user.toJson()).whenComplete(() {
      response.status = 200;
      response.message = "User added successfully";
    }).catchError((e) {
      response.status = 400;
      response.message = "Something went wrong";
    });

    return response;
    // await FirebaseFirestore.instance.collection("users").add(user.toJson()).whenComplete(
    //   () => Get.snackbar("Success", "Your account has been created.",
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.brown,
    //       colorText: Colors.white)
    // ).catchError((error,stackTrace){
    //   Get.snackbar("OOPS!", "Something went wrong.",
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.brown,
    //       colorText: Colors.white);
    // });
  }

  static Future<ResponseUser> fetchUserByEmail(String email) async {
    ResponseUser response = ResponseUser(
        user: UserModel(
      id: "",
      firstName: "",
      email: email,
      lastName: "",
      gender: "",
      role: "",
      avatar: "https://firebasestorage.googleapis.com/v0/b/bitesy-fa8bc.appspot.com/o/default%20avatar%2F804946.png?alt=media&token=b355751e-c501-4740-b263-2204d5e971d5"
    ));
    try {
      QuerySnapshot snapshot = await _users
          .where('Email',
              isEqualTo:
                  email) // Replace 'field' and 'value' with your desired condition
          .limit(1)
          .get();

      if (snapshot.size > 0) {
        UserModel user =
            UserModel.fromJson(snapshot.docs[0].data() as Map<String, dynamic>);
        response.user = user;
        response.status = 200;
        response.message = "User read successfully";
      } else {
        response.status = 200;
        response.message = "User not found."; // No matching documents found
      }
    } catch (error) {
      response.status = 400;
      response.message = error.toString();
    }
    return response;
  }
}
