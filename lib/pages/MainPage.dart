import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototip_tfg/Models/Reserva.dart';
import 'package:prototip_tfg/Models/Restaurant.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:prototip_tfg/controllers/CustomApi.dart';
import 'package:prototip_tfg/pages/DetailReservaPage.dart';
import 'package:prototip_tfg/pages/NewReservaPage.dart';
import 'package:prototip_tfg/pages/NewReservaSecondStep.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:provider/provider.dart';

final Color mainColor = const Color.fromARGB(255, 44, 64, 114);
final Color bgColor = const Color.fromARGB(255, 248, 246, 242);
final Color actionColor = const Color.fromARGB(255, 255, 210, 57);
final Color disabledColor = const Color.fromARGB(50, 153, 153, 153);

final List<TaulaFisica> taulesFisiquesProva = [
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

class DiaProvider with ChangeNotifier {
  DateTime _actualDia;
  DiaProvider(actualDia) {
    this._actualDia = actualDia;
    _getReservasDia();
  }
  bool _isLoading = false;
  dynamic _reservasDia;
  CustomApi api = CustomApi();

  DateTime get actualDia => _actualDia;

  Future<void> _getReservasDia() async {
    _isLoading = true;
    notifyListeners();
    try {
      var stats = await api.getReservasDia(_actualDia);
      _reservasDia = stats;
      debugPrint(stats.toString());
      await new Future.delayed(const Duration(seconds: 1));
      _isLoading = false;
      debugPrint(_isLoading.toString());
      notifyListeners();
    } catch (ex) {
      _reservasDia = null;
      _isLoading = false;
      notifyListeners();
      debugPrint(ex.toString());
      debugPrint("catch EXCEPTION _reservasDia = null");
    } finally {
      _isLoading = false;
      debugPrint("FINALLY");
      notifyListeners();
    }
  }

  void _changeDay(bool direction) async {
    if (direction) {
      _actualDia = _actualDia.add(Duration(hours: 24));
      //debugPrint(_actualDia.toString());
      await _getReservasDia();
      notifyListeners();
    } else {
      _actualDia = _actualDia.add(Duration(hours: -24));
      //debugPrint(_actualDia.toString());
      await _getReservasDia();
      notifyListeners();
    }
  }

  String getDia() {
    var dt = _actualDia;
    var newFormat = DateFormat("EEEE, dd MMMM");
    String updatedDt = newFormat.format(dt);
    return updatedDt;
  }
}

class ServeiProvider with ChangeNotifier {
  TaulesList _taules;
  int _actualTorn;
  int _actualServei;
  DateTime _actualDia = DateTime.now();
  List<Reserva> _reservas = [];

  ServeiProvider(this._actualServei, this._actualTorn);

  void update(DiaProvider diaProvider) async {
    // Do some custom work based on myModel that may call `notifyListeners`
    _actualDia = diaProvider._actualDia;

    if (diaProvider._reservasDia.reservas != null) {
      _reservas = diaProvider._reservasDia.reservas;
      await _setTaulesList();
      notifyListeners();
    }
  }

  TaulesList get taules => _taules;
  int get torn {
    if (_actualServei == 1) {
      return _actualTorn;
    } else {
      return _actualTorn - 1;
    }
  }

  int get servei => _actualServei;

  _setTaulesList() async {
    if (_actualServei == 1) {
      var llistataules = await TaulesList.getLlistaTaules(_actualDia,
          _actualServei, _actualTorn, taulesFisiquesProva, _reservas);
      _taules = llistataules;
      //_actualTorn = 1;

      notifyListeners();
    } else if (_actualServei == 2) {
      var llistataules = await TaulesList.getLlistaTaules(_actualDia,
          _actualServei, _actualTorn, taulesFisiquesProva, _reservas);
      _taules = llistataules;
      //_actualTorn = 1;

      notifyListeners();
    }
  }

  _changeTaulesList(int torn) async {
    if (_actualServei == 2) {
      var llistataules = await TaulesList.getLlistaTaules(
          _actualDia, _actualServei, torn + 1, taulesFisiquesProva, _reservas);
      _taules = llistataules;
      _actualTorn = torn + 1;

      notifyListeners();
    } else {
      var llistataules = await TaulesList.getLlistaTaules(
          _actualDia, _actualServei, torn, taulesFisiquesProva, _reservas);
      _taules = llistataules;
      _actualTorn = torn;

      notifyListeners();
    }
  }
}

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

class BodyTabBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        DinarTab(),
        SoparTab(),
      ],
    );
  }
}

/* Provider.of<DiaProvider>(context, listen: false)._isLoading
        ? CircularProgressIndicator()
        : TabBarView(
          children: <Widget>[
            DinarTab(),
            SoparTab(),
          ],
        ),
 */

class MainPageAppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          onTap: () {
            Provider.of<DiaProvider>(context, listen: false)._changeDay(false);
          },
          child: Icon(Icons.arrow_back),
        ),
        Text(Provider.of<DiaProvider>(context, listen: true).getDia()),
        InkWell(
          onTap: () {
            Provider.of<DiaProvider>(context, listen: false)._changeDay(true);
          },
          child: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}

class DinarTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<DiaProvider>(context, listen: true)._isLoading) {
      return Center(
          child: CircularProgressIndicator(
        strokeWidth: 4,
      ));
    } else {
      return ChangeNotifierProxyProvider<DiaProvider, ServeiProvider>(
          create: (_) => ServeiProvider(1, 1),
          update: (_, diaProvider, serveiProvider) =>
              serveiProvider..update(diaProvider),
          child: TaulesGrid(
            servei: 1,
          ));
    }
  }
}

class SoparTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<DiaProvider>(context, listen: true)._isLoading) {
      return Center(
          child: CircularProgressIndicator(
        strokeWidth: 4,
      ));
    } else {
      return ChangeNotifierProxyProvider<DiaProvider, ServeiProvider>(
          create: (_) => ServeiProvider(2, 2),
          update: (_, diaProvider, serveiProvider) =>
              serveiProvider..update(diaProvider),
          child: TaulesGrid(
            servei: 2,
          ));
    }
  }
}

class TaulesGrid extends StatelessWidget {
  const TaulesGrid({
    Key key,
    @required this.servei,
  }) : super(key: key);

  final int servei;

  @override
  Widget build(BuildContext context) {
    Color getColor(int boto) {
      int tornActual = Provider.of<ServeiProvider>(context).torn;
      if (tornActual == boto) {
        return actionColor;
      } else {
        return Colors.grey[350];
      }
    }

    //Provider.of<ServeiProvider>(context)._setTaulesList();
    if (Provider.of<ServeiProvider>(context).taules == null) {
      Provider.of<ServeiProvider>(context)._setTaulesList();
      return Center(child: CircularProgressIndicator());
    } else {
      final TaulesList _taules = Provider.of<ServeiProvider>(context).taules;
      return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: bgColor,
            floating: false,
            pinned: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Container(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(right: 40, left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: Consumer<ServeiProvider>(
                        builder: (context, provider, _) => RaisedButton(
                          color: getColor(1),
                          child: Text(
                            "Turno 1",
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Provider.of<ServeiProvider>(context, listen: false)
                                ._changeTaulesList(1);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: Consumer<ServeiProvider>(
                        builder: (context, provider, _) => RaisedButton(
                          color: getColor(2),
                          child: Text(
                            "Turno 2",
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Provider.of<ServeiProvider>(context, listen: false)
                                ._changeTaulesList(2);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black26,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index > _taules.taulesInfoList.length - 1) return null;
                return TaulaStack(taula: _taules.taulesInfoList[index]);
              },
              childCount: _taules.taulesInfoList.length,
            ),
          )
        ],
      );
    }
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
    final taula = Provider.of<Taula>(context);
    return Container(
      width: 171,
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        child: InkWell(
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          splashColor: actionColor,
          onTap: () {
            if (taula.isreserva) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DetailReservaPage(reserva: taula.reserva)));
            }
          },
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



class TaulesGridAddReserva extends StatelessWidget {
  const TaulesGridAddReserva({
    Key key,
    @required this.servei,
    
  }) : super(key: key);

  final int servei;
  

  @override
  Widget build(BuildContext context) {
    Color getColor(int boto) {
      int tornActual = Provider.of<ServeiProvider>(context).torn;
      if (tornActual == boto) {
        return actionColor;
      } else {
        return Colors.grey[350];
      }
    }

    //Provider.of<ServeiProvider>(context)._setTaulesList();
    if (Provider.of<ServeiProvider>(context).taules == null) {
      Provider.of<ServeiProvider>(context)._setTaulesList();
      return Center(child: CircularProgressIndicator());
    } else {
      final TaulesList _taules = Provider.of<ServeiProvider>(context).taules;
      return CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: bgColor,
            floating: false,
            pinned: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(120),
              child: Column(
                children: <Widget>[
                  InfoPreviewCard(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: Consumer<ServeiProvider>(
                          builder: (context, provider, _) => RaisedButton(
                            color: getColor(1),
                            child: Text(
                              "Turno 1",
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              Provider.of<ServeiProvider>(context,
                                      listen: false)
                                  ._changeTaulesList(1);
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: Consumer<ServeiProvider>(
                          builder: (context, provider, _) => RaisedButton(
                            color: getColor(2),
                            child: Text(
                              "Turno 2",
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              Provider.of<ServeiProvider>(context,
                                      listen: false)
                                  ._changeTaulesList(2);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SliverGrid(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index > _taules.taulesInfoList.length - 1) return null;
                return TaulaStack(taula: _taules.taulesInfoList[index]);
              },
              childCount: _taules.taulesInfoList.length,
            ),
          )
        ],
      );
    }
  }
}