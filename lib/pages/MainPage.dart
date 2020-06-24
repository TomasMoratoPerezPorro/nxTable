import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototip_tfg/pages/DetailReservaPage.dart';
import 'package:prototip_tfg/pages/NewReservaPage.dart';
import 'package:prototip_tfg/pages/NewReservaSecondStep.dart';
import 'package:prototip_tfg/providers/DiaProvider.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/BodyTabBarView.dart';
import 'package:provider/provider.dart';

import '../global.dart';

class MainPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: false);

    return Scaffold(
      key: _drawerKey,
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: MainPageAppBarTitle(),
        backgroundColor: mainColor,
        bottom: TabBar(
          indicatorColor: actionColor,
          labelPadding: EdgeInsets.all(10),
          tabs: [Text("COMIDA"), Text("CENA")],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: actionColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return NewReservasPage();
              },
            ),
          ).then((result) {
            if (newReservaProvider.reservaConfirmada) {
              Provider.of<DiaProvider>(context, listen: false).refreshDay();
            }
            newReservaProvider.resetData();
          });
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: mainColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.menu),
              onPressed: () {
                _drawerKey.currentState.openDrawer();
              },
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.calendar_today),
              onPressed: () {},
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
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
            Image.asset(
              'assets/images/nxTable_logo_xxs.png',
              height: 70,
              width: 30,
              fit: BoxFit.fitHeight,
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: BodyTabBarView(),
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
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return FutureBuilder<DocumentSnapshot>(
        future:
            Firestore.instance.collection('Usuaris').document(user.uid).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: SizedBox(
                    height: 15, width: 15, child: CircularProgressIndicator()));
          }
          final DocumentSnapshot doc = snapshot.data;
          Map<String, dynamic> fields = doc.data;
          return Text(fields['Name'],
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white));
        });
  }
}

class MainPageAppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          onTap: () {
            Provider.of<DiaProvider>(context, listen: false).changeDay(false);
          },
          child: Icon(Icons.arrow_back),
        ),
        Text(Provider.of<DiaProvider>(context, listen: true).getDia()),
        InkWell(
          onTap: () {
            Provider.of<DiaProvider>(context, listen: false).changeDay(true);
          },
          child: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
