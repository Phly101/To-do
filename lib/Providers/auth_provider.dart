// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/DataBase/Collections/users_collection.dart';
import 'package:to_do/DataBase/Model/app_user.dart';

class AppAuthProvider extends ChangeNotifier {
  UsersCollection usersCollection = UsersCollection();
  User? authUser;
  AppUser? appUser;

  AppAuthProvider() {


    authUser = FirebaseAuth.instance.currentUser;
    if (authUser != null) {
      signInWithUserId(authUser!.uid);
    }
  }

  void signInWithUserId(String uid) async {
    appUser = await usersCollection.readUser(uid);
  }

  bool isLoggedIn() {
    return authUser != null;
  }

  void login(User newUser) {
    authUser = newUser;
  }

  void logout() {
    authUser = null;
    FirebaseAuth.instance.signOut();
  }

  // Separated user creation logic
  Future<AppUser?> addUserToDatabase(AppUser appUser) async {
    try {
      var result = await usersCollection.createUser(appUser);
      return appUser;
    } catch (e) {


      return null;
    }
  }

  Future<AppUser?> createUserWithEmailAndPassword(
      String email, String password, String fullName) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    if (credential.user != null) {
      login(credential.user!);
      AppUser appUser = AppUser(
        authId: credential.user!.uid,
        fullName: fullName,
        email: credential.user!.email!,
      );

     
      return await addUserToDatabase(appUser);
    }
    return null;
  }

  Future<AppUser?> signInWithEmailAndPassword(
      String email, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (credential.user != null) {
      login(credential.user!);
      appUser = await usersCollection.readUser(credential.user!.uid);
    }

    return appUser;
  }



}
