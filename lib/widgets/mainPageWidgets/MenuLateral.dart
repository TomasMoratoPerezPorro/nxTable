import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                UserNameWidget(),
              ],
            ),
            decoration: BoxDecoration(
              color: mainColor,
            ),
          ),
          ListTile(
            title: Text('Log Out'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 300,
          ),
          Image.asset(
            'assets/images/nxTable_logo_xxs.png',
            height: 70,
            width: 30,
            fit: BoxFit.fitHeight,
          ),
        ],
      ),
    );
  }
}

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Usuaris')
            .doc(user.uid)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: SizedBox(
                    height: 15, width: 15, child: CircularProgressIndicator()));
          }
          final DocumentSnapshot doc = snapshot.data;
          Map<String, dynamic> fields = doc.data();
          return Text(fields['Name'],
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white));
        });
  }
}
