import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Group extends StatefulWidget {
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
   File sampleImage;
  Future getImage()async
  {
    var tempImage=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage=tempImage;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(
        child: sampleImage==null?Text('select and image'):enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purpleAccent,
        onPressed: 
        //getImage
        (){},
      ),
    );
  }
  Widget enableUpload()
  {
     return Container(
    //   child: Column(
    //     children: <Widget>[
    //       Padding(
    //         padding: const EdgeInsets.all(40),
    //         child: Center(child: Image.file(sampleImage,height: 300,width: 300,)),
    //       ),
    //       RaisedButton(
    //         elevation: 7.0,
    //         child: Text('upload',style: TextStyle(color: Colors.white),),
    //         color: Colors.pink,
    //         onPressed: ()async{
    //           var randomno=Random(25);
    //             final StorageReference firebaseStorageRef=FirebaseStorage.instance.ref().child(
    //               'profilepics/${randomno.nextInt(5000).toString()}.jpg'
    //             );
    //           //final StorageUploadTask task=firebaseStorageRef.putFile(sampleImage);
    //         },
    //       )
    //     ],
    //   ),
     );
  }
}