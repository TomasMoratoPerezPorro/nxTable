import 'package:flutter/material.dart';
import 'package:prototip_tfg/providers/DiaProvider.dart';
import 'package:provider/provider.dart';

import '../../global.dart';

/* Declares _pickDate() function to select a date from the the DatePicker and stores its value in DiaProvider. When the date changes, the Provider loads the corresponding data (bookings) */

class ScaffoldBottomAppBar extends StatelessWidget {
  const ScaffoldBottomAppBar({
    Key key,
    @required GlobalKey<ScaffoldState> drawerKey,
  })  : _drawerKey = drawerKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _drawerKey;

  @override
  Widget build(BuildContext context) {
    final diaProvider = Provider.of<DiaProvider>(context, listen: false);
    _pickDate() async {
      DateTime date = await showDatePicker(
        context: context,
        locale: const Locale('es', 'ES'),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: diaProvider.actualDia,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: mainColor, //Head background
              accentColor: mainColor, //selection color
              //dialogBackgroundColor: Colors.white,//Background color
              colorScheme: ColorScheme.light(primary: mainColor),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        },
      );

      if (date != null) diaProvider.setDay(date);
    }

    return BottomAppBar(
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
            onPressed: _pickDate,
          ),
        ],
      ),
    );
  }
}
