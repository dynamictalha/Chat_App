import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // instance of auth and direstore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get Current user
  User? getCurrentUser(){
    return _auth.currentUser;
  }


  // sign in
  Future<UserCredential> signWithEmailPassword(String email, password) async{
     try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      // save user info if it already exist
    _firestore.collection("Users")
    .doc(userCredential.user!.uid)
    .set(
      {
        "uid": userCredential.user!.uid,
        "email": email,
      }
    );
      return userCredential;
     } on FirebaseAuthException catch (e){
       throw Exception(e.code);
     }
  }
  // sign up
 Future<UserCredential> signUpWithEmailPassword(String email, password) async{
  try{
    // crate a user
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    // save user info in separate doc
    _firestore.collection("Users")
    .doc(userCredential.user!.uid)
    .set(
      {
        "uid": userCredential.user!.uid,
        "email": email,
      }
    );
    return userCredential;
  }
  on FirebaseAuthException catch (e){
       throw Exception(e.code);
     }
 }

  // sign out
    Future<void> signOut()async{
      return await _auth.signOut();
    }
  // error
}