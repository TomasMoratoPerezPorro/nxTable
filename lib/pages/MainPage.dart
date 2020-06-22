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
  @override
  Widget build(BuildContext context) {
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
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
          ).then((result){
            newReservaProvider.resetData();
            Provider.of<DiaProvider>(context, listen: false).refreshDay(); 
            

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
              onPressed: () {},
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.calendar_today),
              onPressed: () {},
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




















