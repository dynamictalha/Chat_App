import 'package:chat_room_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  // get instance of firebase  and auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // get user stream
/*
List<Map<String,dynamic>>
// ----list of Map
[
Map
{
emai: "",
id: ""
..}

Map
{
emai: "",
id: ""
..}
...
]
*/

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go to each individual user
        final user = doc.data();
        // return user
        return user;
      }).toList();
    });
  }

  // send message

  Future<void> sendMessage(String receiverID, message) async {
    // current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    // create a new message

    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    // construct chat room ID for two users (sorted to show uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // sort the ids (this ensure the classroomID is same for any two people)
    String chatroomID = ids.join('_');

    // add this message to database
    await _firestore
        .collection("chat_room")
        .doc(chatroomID)
        .collection("message")
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessage(String userID, otherUserID) {
    // construct a chatroom ID for two user
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatroomID = ids.join('_');
    return _firestore
        .collection("chat_room")
        .doc(chatroomID)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
