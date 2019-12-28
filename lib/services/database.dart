import 'package:chatt/modal/details.dart';
import 'package:chatt/modal/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
class DatabaseServices
{
  final String uid;
  DatabaseServices({this.uid});
  final CollectionReference userCollection=Firestore.instance.collection('users');
  Future updateUserData(String name,String email,String profilepic) async
  {
    return await userCollection.document(uid).setData({
      'name':name,
      'email':email,
      'profilepic':profilepic,
      'uid':uid
    });
  }
  //getting data from snapshot
  List<Details> _usersFromSnapshot(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc)
    {
      return Details(
        uid: doc.data['uid'],
        name: doc.data['name'],
        email: doc.data['email'],
        profilepic: doc.data['profilepic'],

      );
    }).toList();
  }

  //getting data from user

  Stream<List<Details>> get details
  {
    return userCollection.snapshots().map(_usersFromSnapshot);
  }
  UserName _userNameFromSnapshot(DocumentSnapshot snapshot)
  {
    return UserName(
      uid: uid,
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      profilepic: snapshot.data['profilepic']
    );
  }
  Stream<UserName> get userName
  {
    return userCollection.document(uid).snapshots().map(_userNameFromSnapshot);

  }  
}