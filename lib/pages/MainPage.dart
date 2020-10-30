import 'package:flutter/material.dart';
import 'package:prototip_tfg/providers/DiaProvider.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/BodyTabBarView.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/FloatingActionButtonNewReserva.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/MenuLateral.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/ScaffoldBottomAppBar.dart';
import 'package:provider/provider.dart';

import '../global.dart';

/* MainPage WIDGET:
- Contains a final reference to both main providers (NewReservaProvider and DiaProvider) in order to access its data.
- Contains a GlovalKey for the drawer

- Contains as a title for the AppBar widget MainPageAppBarTitle() a widget used for controlling the navigation betwen days (+24h / -24h)
- Below that there is a TabBar in charge of switching betwen services (COMIDA - CENA)
- At the bottom of the Scaffold there is a FloatingActionButton for creating a new reservation and starting this flow.
- It contains a bottomNavigationBar that offers access to the Drawer (MenuLateral) and to the DatePiker flow to navigate through the calendar.
- It's child is BodyTabBarView that contains both service tabs DinarTab and SoparTab


 */

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
      floatingActionButton: FloatingActionButtonNewReserva(
          newReservaProvider: newReservaProvider),
      bottomNavigationBar: ScaffoldBottomAppBar(drawerKey: _drawerKey),
      drawer: MenuLateral(),
      body: SafeArea(
        child: BodyTabBarView(),
      ),
    );
  }
}

/* MainPageAppBarTitle: 
Shows the actual date provided by DiaProvider in the center of the widget.
In both sides there are two buttons in charge of changing the day and navigate forward or backwords.
This buttons call DiaProvider method (changeDay) in charge of adding 24h duration to the actual day.
If the boolean sent is true it goes forward, if it's false backwards (-24h)
 */

class MainPageAppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 60,
          width: 50,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            onTap: () {
              Provider.of<DiaProvider>(context, listen: false).changeDay(false);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        Text(Provider.of<DiaProvider>(context, listen: true).getDia()),
        Container(
          height: 60,
          width: 50,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            onTap: () {
              Provider.of<DiaProvider>(context, listen: false).changeDay(true);
            },
            child: Icon(Icons.arrow_forward),
          ),
        ),
      ],
    );
  }
}
