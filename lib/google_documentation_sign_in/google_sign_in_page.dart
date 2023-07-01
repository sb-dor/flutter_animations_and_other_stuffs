import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInPage extends StatefulWidget {
  const GoogleSignInPage({Key? key}) : super(key: key);

  @override
  State<GoogleSignInPage> createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
              color: Colors.amber,
              onPressed: () async {
                if (await _googleSignIn.isSignedIn()) {
                  _googleSignIn.signOut().then((value) {
                    setState(() {
                      email = '';
                    });
                  });
                } else {
                  await _googleSignIn.signIn().then((value) {
                    setState(() {
                      debugPrint("id: ${value?.id}");
                      debugPrint("email: ${value?.email}");
                      debugPrint("displayName: ${value?.displayName}");
                      debugPrint("photo_url: ${value?.photoUrl}");
                      email = value?.email ?? '';
                    });
                  });
                }
              },
              child: Text("Click to Register")),
          SizedBox(height: 10),
          Text("$email")
        ],
      ),
    ));
  }
}
