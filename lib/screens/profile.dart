import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:chatt/modal/details.dart';
import 'package:chatt/modal/user.dart';
import 'package:chatt/services/auth.dart';
import 'package:chatt/shared/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:chatt/services/database.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
 final AuthServices _auth=AuthServices();
 
//   var dp;
//   String name;
//      File sampleImage;
//   Future getImage()async
//   {
//     var tempImage=await ImagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       sampleImage=tempImage;
//     });
//      var randomno=Random(25);
//     final StorageReference firebaseStorageRef=await FirebaseStorage.instance.ref().child(
//                   'profilepics/${randomno.nextInt(5000).toString()}.jpg'
//                 );
//     final StorageUploadTask task=await firebaseStorageRef.putFile(sampleImage);

//     StorageTaskSnapshot taskSnapshot=await task.onComplete;
//     String downloadUri =await taskSnapshot.ref.getDownloadURL();
//     await _auth.updateProfilePic(downloadUri);
//      FirebaseAuth.instance.currentUser().then((user)
//     {
//       setState(() {
//         dp=user.photoUrl;
//       });
//     }).catchError((e){
//       print(e);
//     });
//   }
//   @override
//   void init()
//   {
//     super.initState();
//     FirebaseAuth.instance.currentUser().then((user)
//     {
//       setState(() {
//         dp=user.photoUrl;
//         print(user.displayName);
//       });
//     }).catchError((e){
//       print(e);
//     });
//   }
  @override
  Widget build(BuildContext context) { 
    String name='';
    var dp;
    //funtion for getting the uservalue
    showEditDialog()
    {
       showModalBottomSheet(isScrollControlled: true,context: context,builder: (context)
            {
              return Settings();
            });
  
    }
    final user=Provider.of<User>(context);
        final details=Provider.of<List<Details>>(context);
        // print(details); 
        details.forEach((val)
        {
          if(val.uid==user.uid)
          {
            setState(() {
              name=val.name;
              dp=val.profilepic;
            });
          }
        });

        return Scaffold(
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child:Container(color: Colors.purple.withOpacity(0.1)),
              clipper:getClipper(),
            ),
            Positioned(
              width: 350.0,
              top: MediaQuery.of(context).size.height/6,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                        image: NetworkImage(dp),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(75.0),
                      boxShadow:[
                        BoxShadow(blurRadius: 7.0,color: Colors.pink,spreadRadius: 0)
                      ]
                    ),
                  ),
                  SizedBox(height:30,),
                  Text(name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Mono'
                  ),
                  ),
                  SizedBox(height: 60.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center
                    ,children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 35,width: 95,
                      child: Material(
                        borderRadius: BorderRadius.circular(2),
                        shadowColor: Colors.purpleAccent,
                        color: Colors.pink,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: (){
                            // getImage();
                          },
                          child: Center(
                            child: Text('Change Dp',
                            style: TextStyle(
                              fontFamily: 'Mono',
                              color: Colors.white
                            ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 35,width: 95,
                      child: Material(
                        borderRadius: BorderRadius.circular(2),
                        shadowColor: Colors.redAccent,
                        color: Colors.pink,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: (){    
                            showEditDialog();
                          },
                          child: Center(
                            child: Text('Edit Name',
                            style: TextStyle(
                              fontFamily: 'Mono',
                              color: Colors.white
                            ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 35,width: 95,
                      child: Material(
                        borderRadius: BorderRadius.circular(2),
                        shadowColor: Colors.redAccent,
                        color: Colors.pink,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () async{    
                                 _auth.signOut();
                          },
                          child: Center(
                            child: Text('Logout',
                            style: TextStyle(
                              fontFamily: 'Mono',
                              color: Colors.white
                            ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ],)
                  
                ],
              ),
            )
          ],
        ),
      );
  }
}
class getClipper extends CustomClipper<Path>
{
  @override
  Path getClip(Size size)
  {
    var path=new Path();
    path.lineTo(0.0, size.height/2.2);
    path.lineTo(size.width+224, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)
  {
    return true;
  }
}