import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:provider/provider.dart';

final Color mainColor = const Color.fromARGB(255, 44, 64, 114);
final Color bgColor = const Color.fromARGB(255, 248, 246, 242);
final Color actionColor = const Color.fromARGB(255, 255, 210, 57);
final Color disabledColor = const Color.fromARGB(50, 153, 153, 153);

class NewReservaProvider with ChangeNotifier {
  DateTime _actualDia = DateTime.now();
  int _numComensales;
  int _idServicio = 0;
  String _nom;
  String _telefon;
  int _idTorn;
  int _estat;
  int _idTaula;

  int get servei => _idServicio;

  void _setDia(DateTime dia) {
    this._actualDia = dia;

    notifyListeners();
  }

  void _setServei(int idServei) {
    this._idServicio = idServei;
    notifyListeners();
  }

  String getDia() {
    var dt = _actualDia;
    var newFormat = DateFormat("EEEE, dd MMMM");
    String updatedDt = newFormat.format(dt);
    return updatedDt;
  }

  void _setNumComensales(int i) {
    this._numComensales = i;
    notifyListeners();
  }
}

class NewReservasPage extends StatefulWidget {
  @override
  _NewReservasPageState createState() => _NewReservasPageState();
}

class _NewReservasPageState extends State<NewReservasPage> {
  int bottomSelectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        NewReservaFirstStep(),
        NewReservaFirstStep(),
        NewReservaFirstStep(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('New Reserva'),
        backgroundColor: mainColor,
      ),
      bottomNavigationBar: BottomAppBar(
          color: mainColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                bottomSelectedIndex == 0
                    ? SizedBox(
                        height: 35,
                      )
                    : InkWell(
                        onTap: () {
                          if (bottomSelectedIndex > 0) {
                            bottomTapped(bottomSelectedIndex - 1);
                          }
                        },
                        child: Icon(Icons.arrow_back,
                            size: 25, color: Colors.white),
                      ),
                SizedBox(
                  height: 35,
                ),
                bottomSelectedIndex == 2
                    ? SizedBox(
                        height: 35,
                      )
                    : InkWell(
                        onTap: () {
                          if (bottomSelectedIndex < 2) {
                            bottomTapped(bottomSelectedIndex + 1);
                          }
                        },
                        child: Icon(Icons.arrow_forward,
                            size: 25, color: Colors.white),
                      ),
              ],
            ),
          )),
      body: buildPageView(),
    );
  }
}

class NewReservaFirstStep extends StatelessWidget {
  const NewReservaFirstStep({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TopInfoBar(),
          ComensalesCard(),
          ServicioCard(),
          CalendarCard(),
        ],
      ),
    );
  }
}

class CalendarCard extends StatefulWidget {
  CalendarCard({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CalendarCardState createState() => new _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  //  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        new DateTime(2019, 2, 25),
        new Event(
          date: new DateTime(2019, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        new DateTime(2019, 2, 10),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(new DateTime(2019, 2, 11), [
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 4',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 23',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 123',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: false);

    /// Example with custom icon
    _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
        newReservaProvider._setDia(_currentDate2);
      },
      weekendTextStyle: TextStyle(
        color: Colors.grey,
      ),
      thisMonthDayBorderColor: Colors.grey,
      //          weekDays: null, /// for pass null when you do not want to render weekDays
      headerText: _currentMonth,
      //          markedDates: _markedDate,
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 400,
      selectedDateTime: _currentDate2,
      showIconBehindDayText: true,
      //          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      todayButtonColor: Colors.transparent,
      todayBorderColor: Colors.green,
      firstDayOfWeek: 1,
      weekdayTextStyle: TextStyle(fontSize: 14.0, color: Colors.grey[300]),
      selectedDayButtonColor: actionColor,
      onCalendarChanged: (DateTime date) {
        this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
      },

      markedDateMoreShowTotal:
          false, // null for not showing hidden events indicator
      //          markedDateIconMargin: 9,
      //          markedDateIconOffset: 3,
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Selecciona una fecha:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: actionColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Center(
                  child: Text(
                    Provider.of<NewReservaProvider>(context, listen: true)
                        .getDia(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                child: _calendarCarousel,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ServicioCard extends StatelessWidget {
  const ServicioCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor(int boto) {
      int serveiActual = Provider.of<NewReservaProvider>(context).servei;
      if (serveiActual == boto) {
        return actionColor;
      } else {
        return Colors.grey[350];
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Selecciona el servicio:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Consumer<NewReservaProvider>(
                      builder: (context, provider, _) => RaisedButton(
                        color: getColor(1),
                        child: Text(
                          "Comida",
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Provider.of<NewReservaProvider>(context,
                                  listen: false)
                              ._setServei(1);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Consumer<NewReservaProvider>(
                      builder: (context, provider, _) => RaisedButton(
                        color: getColor(2),
                        child: Text(
                          "Comida",
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Provider.of<NewReservaProvider>(context,
                                  listen: false)
                              ._setServei(2);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ComensalesCard extends StatelessWidget {
  const ComensalesCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "Selecciona el nº de comensales:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Row(children: <Widget>[
                  for (var i = 1; i < 8; i++) ComensalesButton(id: i),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ComensalesButton extends StatelessWidget {
  const ComensalesButton({
    Key key,
    @required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    Color getColor(int boto) {
      int numComensalesActual =
          Provider.of<NewReservaProvider>(context)._numComensales;
      if (numComensalesActual == boto) {
        return actionColor;
      } else {
        return Colors.grey[350];
      }
    }

    return ButtonTheme(
      minWidth: 10,
      height: 30,
      child: RaisedButton(
        onPressed: () {
          Provider.of<NewReservaProvider>(context, listen: false)
              ._setNumComensales(id);
        },
        child: Text(
          id.toString(),
          style: TextStyle(fontSize: 12),
        ),
        color: getColor(id),
      ),
    );
  }
}

class TopInfoBar extends StatelessWidget {
  const TopInfoBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 2.0), //(x,y)
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text("Selecciona una fecha y servicio disponibles:"),
      ),
    );
  }
}
