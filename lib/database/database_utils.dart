import 'package:chat_c7_fri/models/message.dart';
import 'package:chat_c7_fri/models/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/room.dart';

class DataBaseUtils {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.COLLECTION_NAME)
        .withConverter<MyUser>(
            fromFirestore: (snap, _) => MyUser.fromJson(snap.data()!),
            toFirestore: (user, _) => user.toJson());
  }

  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.COLLECTION_NAME)
        .withConverter<Room>(
            fromFirestore: (snap, _) => Room.fromJson(snap.data()!),
            toFirestore: (room, _) => room.toJson());
  }

  static CollectionReference<Message> getMessagesCollection(String roomId) {
    return getRoomsCollection()
        .doc(roomId)
        .collection(Message.COLLECTION_NAME)
        .withConverter<Message>(
          fromFirestore: (snapshot, options) =>
              Message.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addMessageToFirestore(Message message) {
    var docRef = getMessagesCollection(message.roomId).doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> readMessagesFromFirebase(
      String roomId) {
    return getMessagesCollection(roomId).orderBy("dateTime").snapshots();
  }

  static Future<void> addRoomToFirebase(Room room) {
    var docRef = getRoomsCollection().doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> getRoomFromFirebase() async {
    var snapShotRoom = await getRoomsCollection().get();
    List<Room> rooms = snapShotRoom.docs.map((doc) => doc.data()).toList();
    return rooms;
  }

  static Future<void> addUserToFirestore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFirestore(String id) async {
    DocumentSnapshot<MyUser> UserRef = await getUsersCollection().doc(id).get();
    return UserRef.data();
  }
}
