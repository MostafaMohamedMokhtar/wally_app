import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wally_app/config/config.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image(
              image: AssetImage('assets/bg.jpg'),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Container(
              width:  MediaQuery.of(context).size.width,
              height: 180,
              margin: EdgeInsets.only(top: 100),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: Image(
                  image: AssetImage('assets/logo_foreground.png'),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height ,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF000000) ,
                    Color(0x00000000) ,
                  ] ,
                  begin: Alignment.bottomCenter ,
                  end: Alignment.topCenter
                )
              ),
            ),
            Positioned(
              bottom: 40,
             left: 0,
             right: 0,
             // width: MediaQuery.of(context).size.width,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor ,
                      secondaryColor ,
                    ],
                    begin: Alignment.topLeft ,
                    end:  Alignment.bottomRight
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 20 , horizontal: 20),
                child: InkWell(
                  onTap: signInWithGoogle,
                  child: Text('Google Sign IN' ,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void signInWithGoogle() async{
   try{
     final GoogleSignInAccount googleUser = await _googleSignIn.signIn() ;
     final GoogleSignInAuthentication googleAuth = await googleUser.authentication ;

     final AuthCredential credential = GoogleAuthProvider.credential(
         accessToken: googleAuth.accessToken ,
         idToken: googleAuth.idToken
     ) ;
     final User user = (await _auth.signInWithCredential(credential)).user ;
     print('signed in ${user.displayName}');
     /////////////////////////////////////////////////
     _db.collection('users').doc(user.uid).set({
       'displayName' : user.displayName ,
       'email' : user.email ,
       'userId' : user.uid ,
       'photoURL' : user.photoURL,
       'lastSignIn' : DateTime.now() ,
     });
   }
   catch(e){
     print(e.message);
   }
  } // end signInWithGoogle()
}
