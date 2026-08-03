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
deleteEventInFirestore(EventDM event) {}

addEventToUserFavorites(String eventId) {}

removeEventFromFavorites(String eventId) {}

updateUserProfile(UserDM user) {}

///                       Events methods      ///////////////////////////////

Future<List<EventDM>> getEventsByCategory(String category) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection(EventDM.collectionName)
      .get();
  var documents = querySnapshot.docs;
  return documents
      .map(
        (snapshot) => EventDM.fromJson(snapshot.data() as Map<String, dynamic>),
      )
      .toList();
}

// Future<List<EventDM>> getFavoriteEvents() async {
//
// }

createEventInFirestore(EventDM event) {
  CollectionReference eventsCollection = FirebaseFirestore.instance.collection(
    EventDM.collectionName,
  );
  eventsCollection.add(event.toJson());
}

updateEventInFirestore(EventDM event) {}
