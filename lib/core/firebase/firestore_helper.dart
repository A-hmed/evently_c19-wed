import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c19/model/event_dm.dart';
import 'package:evently_c19/model/user_dm.dart';

///           User methods ////////////////
Future<void> createUserInFirestore(UserDM user) async {
  CollectionReference userCollection = FirebaseFirestore.instance.collection(
    "users",
  );
  userCollection.doc(user.id).set(user.toJson());
}

Future<UserDM> getUserFromFirestore(String id) async {
  CollectionReference userCollection = FirebaseFirestore.instance.collection(
    UserDM.collectionName,
  );
  DocumentReference reference = userCollection.doc(id);
  DocumentSnapshot userSnapshot = await reference.get();

  var json = userSnapshot.data() as Map<String, dynamic>;
  return UserDM.fromJson(json);
}

///Task
addEventToUserFavorites(String eventId) {
  var favoriteEvents = UserDM.currentUser.favorites;
  favoriteEvents.add(eventId);
  print("favoriteEvents: $favoriteEvents");
  FirebaseFirestore.instance
      .collection(UserDM.collectionName)
      .doc(UserDM.currentUser.id)
      .update({"favorites": favoriteEvents});
}

removeEventFromFavorites(String eventId) {
  var favoriteEvents = UserDM.currentUser.favorites;
  favoriteEvents.remove(eventId);
  FirebaseFirestore.instance
      .collection(UserDM.collectionName)
      .doc(UserDM.currentUser.id)
      .update({"favorites": favoriteEvents});
}

updateUserProfile(UserDM user) {}

///                       Events methods      ///////////////////////////////

Stream<List<EventDM>> getAllEvents() {
  Stream<QuerySnapshot> streamQuerySnapshot = FirebaseFirestore.instance
      .collection(EventDM.collectionName)
      .snapshots();

  return streamQuerySnapshot.map((querySnapshot){
    var documents = querySnapshot.docs;
    return documents
        .map((snapshot) =>
        EventDM.fromJson(snapshot.data() as Map<String, dynamic>),)
        .toList();
  });

}

Future<List<EventDM>> getFavoriteEvents() async {
  var eventsCollection = FirebaseFirestore.instance.collection(
    EventDM.collectionName,
  );
  var querySnapshot = await eventsCollection
      .where("id", whereIn: UserDM.currentUser.favorites)
      .get();
  var documents = querySnapshot.docs;
  var events = documents.map((doc) {
    var json = doc.data();
    return EventDM.fromJson(json);
  }).toList();
  // events =
  //     events.where((event) =>
  //         UserDM.currentUser.favorites.contains(event.id)).toList();
  return events;
}

Future createEventInFirestore(EventDM event) async {
  CollectionReference eventsCollection = FirebaseFirestore.instance.collection(
    EventDM.collectionName,
  );

  ///Create a doc with auto generated id
  var emptyDoc = eventsCollection.doc();
  event.id = emptyDoc.id;
  await emptyDoc.set(event.toJson());
}

updateEventInFirestore(EventDM event) {}
