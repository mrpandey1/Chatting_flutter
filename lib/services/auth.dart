import 'package:chatt/modal/user.dart';
import 'package:chatt/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
class AuthServices
{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  
  final String uid;
  AuthServices({this.uid});
  User _userFromFirebaseUser(FirebaseUser user)
  {
    return user !=null? User(uid:user.uid):null;
  }
  Stream<User> get user{
    return  _auth.onAuthStateChanged.map(_userFromFirebaseUser); 
  }
  
  Future userRegistrationwithEmailPasssword(String email,String password,String name) async
  {
    try{
      var now=DateTime.now();
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email,password: password);
      FirebaseUser user=result.user;
      await DatabaseServices(uid: user.uid).updateUserData(
        name,
        email,
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRn5pvPtaWxy-oW9MVVVA5Gcg4CxfXGXCRKvsKNeQKjOBRbOAgcLw&s'
        ,DateFormat('dd-mm-yyyy').format(now)
        );
      return user;
    }catch(e)
    {
      print(e);
      return null;
    }
  }
  Future userLoginWithEmailAndPassword(String email,String password) async
  {
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email:email,password: password);
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e)
    {
      print(e);
      return null;
    }
  }
  Future signOut() async
  {
    try
    {
     return await _auth.signOut();
    }catch(e)
    {
      return null;
    }
  }
  




















































  
//   updateData(selectedDoc,newValues)
//   {
//     Firestore.instance.collection('Details').document(selectedDoc).updateData(newValues).catchError((e)
//     {
//       print(e);
//     });
//   }
  
// final CollectionReference brewCollection=Firestore.instance.collection('Details');
  
//   updateProfilePic(picUrl) async
//   {
//     UserUpdateInfo info = new UserUpdateInfo();
//     info.photoUrl=picUrl;
//     FirebaseUser user = await FirebaseAuth.instance.currentUser();;
//     user.updateProfile(info).then((val)
//     {
//       FirebaseAuth.instance.currentUser().then((user)
//       {
//         Firestore.instance.collection('/Details').where('uid', isEqualTo: user.uid).
//         getDocuments().then((docs)
//         {
//           Firestore.instance.document('/Details/${docs.documents[0].documentID}').updateData({'profilepic':picUrl}).then((val){
//               print('updated');
//           }).catchError((e)
//           {
//             print(e);
//           });
//         }).catchError((e)
//         {
//           print(e);
//         });
//       }).catchError((e){
//         print(e);
//       });
//     }).catchError((e)
//     {
//       print(e);
//     });
//   }
}