// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_app/Core/Utils/ConstantsNames.dart';

class SignIn {
  static Future<UserCredential> signIn(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }
}

class AccountData {
  // FullName
  static Future<String?> getFullNameFromFirestore(String uid) async {
    var d = await FirebaseFirestore.instance.collection(ConstantNames.usersDataCollection).doc(uid).get();
    return d.data()![ConstantNames.fullName];
  }

  // Email
  static Future<String?> getEmailFromFirestore(String uid) async {
    var d = await FirebaseFirestore.instance.collection(ConstantNames.usersDataCollection).doc(uid).get();
    return d.data()![ConstantNames.email];
  }

  static Future<String?> getEmailFromFirebaseAuth(String uid) async {
    User? user = await FirebaseAuth.instance.userChanges().firstWhere((user) => user!.uid == uid);
    return user?.email;
  }

  // UID
  static Future<String?> getUIDFromFirestore(String email) async {
    QuerySnapshot uidDocument = await FirebaseFirestore.instance.collection(ConstantNames.usersDataCollection).where(ConstantNames.email, isEqualTo: email).limit(1).get();
    return uidDocument.docs[0].id;
  }

  // Password
  static Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  // Get All User Data From Firestore
  static Future<Map<String, dynamic>?> getUserDataFromFirestore(String uid) async {
    // return user data without password
    var data = await FirebaseFirestore.instance.collection(ConstantNames.usersDataCollection).doc(uid).get();
    return data.data();
  }
}

class Register {
  static Future<UserCredential> register(Map<String, dynamic> userData, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userData[ConstantNames.email], password: password);
    userData[ConstantNames.uid] = userCredential.user!.uid;
    await FirebaseFirestore.instance.collection(ConstantNames.usersDataCollection).doc(userCredential.user!.uid).set(userData, SetOptions(merge: true));
    return userCredential;
  }
}

class SignOut {
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> deleteAccount(String uid) async {
    await FirebaseFirestore.instance.collection(ConstantNames.usersDataCollection).doc(uid).delete();
    await FirebaseAuth.instance.currentUser!.delete();
  }
}

class Verification {
  static Future<void> sendVerification() async {
    return await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  static bool isVerified() {
    return FirebaseAuth.instance.currentUser!.emailVerified;
  }
}

// For Authentication
// in cmd --> flutter pub add firebase_core
// in cmd --> flutter pub add firebase_auth
// in cmd --> flutter pub add cloud_firestore
// in cmd --> flutter pub add google_sign_in

