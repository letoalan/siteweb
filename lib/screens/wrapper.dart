import 'package:website/screens/authentification/sign_in.dart';
import 'package:website/screens/authentification/authenticate.dart';
import 'package:website/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:website/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final userr = Provider.of<NewUser>(context);
    print(userr);



    // return either home or authenticate
    if (userr == null) {
      return Authenticate();
    } else {
      return Home();
     }
   }
}