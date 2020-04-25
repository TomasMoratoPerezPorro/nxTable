import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Restaurant.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Color mainColor = const Color.fromARGB(255, 44, 64, 114);
  Color bgColor = const Color.fromARGB(255, 248, 246, 242);
  Color actionColor = const Color.fromARGB(255, 255, 210, 57);

  TaulesList _taules;

  List<TaulaFisica> taulesFisiquesProva = [
    TaulaFisica(1, 2),
    TaulaFisica(2, 2),
    TaulaFisica(3, 2),
    TaulaFisica(4, 2),
    TaulaFisica(5, 2),
    TaulaFisica(6, 2),
    TaulaFisica(7, 2),
    TaulaFisica(8, 2),
    TaulaFisica(9, 2),
    TaulaFisica(10, 2),
    TaulaFisica(11, 2),
    TaulaFisica(12, 4),
    TaulaFisica(13, 4),
    TaulaFisica(14, 4),
    TaulaFisica(15, 4),
    TaulaFisica(16, 4),
  ];

  @override
  void initState() {
    super.initState();
    TaulesList.getLlistaTaules(DateTime.now(), 1, 1, taulesFisiquesProva)
        .then((llistataules) {
      setState(() {
        _taules = llistataules;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_taules == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: Center(child: Text('NxTable')),
          backgroundColor: mainColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.black,
          backgroundColor: actionColor,
          child: const Icon(Icons.add),
          onPressed: () {},
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
        body: TaulesGrid(taules: _taules),
      );
    }
  }
}

class TaulesGrid extends StatelessWidget {
  const TaulesGrid({
    Key key,
    @required TaulesList taules,
  })  : _taules = taules,
        super(key: key);

  final TaulesList _taules;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(onPressed: (){}),
        Flexible(
          flex:1,
          child: GridView.count(
              crossAxisCount: 3,
              //shrinkWrap: true,
              //physics: ScrollPhysics(),
              children: <Widget>[
                for (var taula in _taules.taulesInfoList)
                  GridTile(
                    child: TaulaStack(taula: taula),
                  )
              ]),
        ),
      ],
    );
  }
}

class TaulaStack extends StatelessWidget {
  const TaulaStack({
    Key key,
    @required this.taula,
  }) : super(key: key);

  final Taula taula;

  @override
  Widget build(BuildContext context) {
    return Provider<Taula>.value(
      value: taula,
      child: Stack(children: <Widget>[
        IndicadorEstat(),
        TaulaInfoCard(),
      ]),
    );
  }
}

class TaulaInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 171,
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TaulaInfoCardNom(),
            TaulaInfoCardCapacitat(),
            TaulaInfoCardId()
          ],
        ),
      ),
    );
  }
}

class TaulaInfoCardId extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taula = Provider.of<Taula>(context);
    return Expanded(
      flex: 2,
      child: Row(
        //Rctange Inferior
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 6),
              height: 30,
              decoration: BoxDecoration(
                color: (taula.isreserva
                    ? Color.fromARGB(255, 14, 47, 65)
                    : Colors.grey),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Taula ${taula.id.toString()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaulaInfoCardCapacitat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taula = Provider.of<Taula>(context);
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(top: 5, right: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              taula.maxpersonas.toString() + ' ',
              style: TextStyle(fontSize: 10),
            ),
            Icon(
              Icons.people,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class TaulaInfoCardNom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taula = Provider.of<Taula>(context);
    return Expanded(
      flex: 3,
      child: Row(
        //Text Central
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                (taula.isreserva ? taula.reserva.nom : 'Lliure'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IndicadorEstat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taula = Provider.of<Taula>(context);
    return Container(
      //indicador estat
      margin: EdgeInsets.only(left: 27, top: 2),
      width: 35,
      height: 40,
      decoration: BoxDecoration(
          color: (taula.isreserva
              ? taula.reserva.getColorEstat()
              : Color.fromARGB(0, 250, 62, 87)),
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }
}
