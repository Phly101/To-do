import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/DataBase/Model/app_user.dart';

class UsersCollection {
  Future<void> createUser(AppUser user) async {
    await getUsersCollection().doc(user.authId).set(user);
  }

  static CollectionReference<AppUser> getUsersCollection() {
    var db = FirebaseFirestore.instance;

    return db.collection("users").withConverter(
      fromFirestore: (snapshot, options) {
        return AppUser.fromFireStore(snapshot.data());
      },
      toFirestore: (obj, options) {
        return
          obj.toFireStore();

      }
    );
  }

  Future<AppUser?> readUser(String uid) async {
    var docSnapshot = await getUsersCollection().doc(uid).get();
    return docSnapshot.data();
  }
}
