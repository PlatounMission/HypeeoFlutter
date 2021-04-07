


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app_config.dart';
import '../constants.dart';

class AppService {

  Future loginAnonymously() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();

    } catch(e) {
      print(e);
    }
    return null;
  }

  Future<Map<String, dynamic>?> retrieveLoggedinUserInfo() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        CollectionReference users =
        FirebaseFirestore.instance.collection('users');

        DocumentReference _docRef = users.doc(currentUser.email);

        DocumentSnapshot snapshot = await _docRef.get();

        return Future.value(snapshot.data());
      }
    } catch (e) {
      print(e);
    }

    return Future.value(null);
  }

  Future<Map<String, dynamic>?> searchStreamerByName(String searchText) async {
    try {
      CollectionReference users =
      FirebaseFirestore.instance.collection('users');

      QuerySnapshot snapshot =
      await users
          .where("twitch_channel", isEqualTo: searchText)
          .where("is_streamer", isEqualTo: true)
          .where("is_streamer_validated", isEqualTo: true)
          .get();

      Map<String, dynamic>? _data = snapshot.docs.first.data();

      return Future.value(_data);
    } catch (e) {
      print(e);
    }
    return null;
  }
}