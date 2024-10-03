import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_app/Core/Utils/ConstantsNames.dart';

class SignIn {
  SignIn();

  Future<UserCredential> signIn(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }
}

class AccountData {
  AccountData();

  // FullName
  Future<String?> getFullNameFromFirestore(String uid) async {
    var d = await FirebaseFirestore.instance.collection(ConstantNames.usersDataCollection).doc(uid).get();
    return d.data()![ConstantNames.fullNameField];
  }

  // Email
  Future<String?> getEmailFromFirestore(String uid) async {
    var d = await FirebaseFirestore.instance.collection(ConstantNames.usersDataCollection).doc(uid).get();
    return d.data()![ConstantNames.emailField];
  }

  Future<String?> getEmailFromFirebaseAuth(String uid) async {
    User? user = await FirebaseAuth.instance.userChanges().firstWhere((user) => user!.uid == uid);
    return user?.email;
  }

  // UID
  Future<String?> getUIDFromFirestore(String email) async {
    QuerySnapshot uidDocument = await FirebaseFirestore.instance.collection(ConstantNames.usersDataCollection).where(ConstantNames.emailField, isEqualTo: email).limit(1).get();
    return uidDocument.docs[0].id;
  }

  // Password
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  // Get All User Data From Firestore
  Future<Map<String, dynamic>?> getUserDataFromFirestore(String uid) async {
    // return user data without password
    var data = await FirebaseFirestore.instance.collection(ConstantNames.usersDataCollection).doc(uid).get();
    return data.data();
  }
}

class Register {
  Register();

  Future<UserCredential> register(Map<String, dynamic> userData, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userData[ConstantNames.emailField], password: password);
    userData[ConstantNames.uidField] = userCredential.user!.uid;
    await FirebaseFirestore.instance.collection(ConstantNames.usersDataCollection).doc(userCredential.user!.uid).set(userData, SetOptions(merge: true));
    return userCredential;
  }
}

class SignOut {
  SignOut();

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> deleteAccount(String uid) async {
    await FirebaseFirestore.instance.collection(ConstantNames.usersDataCollection).doc(uid).delete();
    await FirebaseAuth.instance.currentUser!.delete();
  }
}

class Verification {
  Verification();

  Future<void> sendVerification() async {
    return await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  bool isVerified() {
    return FirebaseAuth.instance.currentUser!.emailVerified;
  }
}
