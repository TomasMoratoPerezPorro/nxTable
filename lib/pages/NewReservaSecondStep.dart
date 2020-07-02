import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/ReservasDia.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:prototip_tfg/providers/DiaProvider.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:prototip_tfg/providers/SeleccioTaulaProvider.dart';
import 'package:prototip_tfg/providers/ServeiProvider.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/DinarTab.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/TaulaInfoCardCapacitat.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/TaulaInfoCardId.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/TaulaInfoCardNom.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/TaulaStack.dart';
import 'package:provider/provider.dart';

import '../global.dart';

class NewReservaSecondStep extends StatelessWidget {
  const NewReservaSecondStep({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SeleccioDeTaules();
  }
}

class SeleccioDeTaules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TaulesGridAddReserva(
        servei: Provider.of<NewReservaProvider>(context, listen: false).servei);
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
    final seleccioTaulaProvider =
        Provider.of<SeleccioTaulaProvider>(context, listen: true);

    return seleccioTaulaProvider.reservasDia == null
        ? CircularProgressIndicator(strokeWidth: 4)
        : CustomScrollViewTaules();
  }
}
/* 
class TaulesGridAddReserva extends StatelessWidget {
  const TaulesGridAddReserva({
    Key key,
    @required this.servei,
  }) : super(key: key);

  final int servei;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReservasDia>(
      future: Provider.of<SeleccioTaulaProvider>(context, listen: false)
          .getReservasDia(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text(
              'Fetch chuck joke.',
              textAlign: TextAlign.center,
            );
          case ConnectionState.active:
            return Text('');
          case ConnectionState.waiting:
            return Center(
                child: Container(
                    child: CircularProgressIndicator(strokeWidth: 4)));
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text("Error");
            } else {
              return CustomScrollViewTaules();
            }
        }
        return CircularProgressIndicator(strokeWidth: 4);
      },
    );
  }
} */

/* class TaulesGridAddReserva extends StatelessWidget {
  const TaulesGridAddReserva({
    Key key,
    @required this.servei,
  }) : super(key: key);

  final int servei;

  @override
  Widget build(BuildContext context) {
    final reservas =
        Provider.of<SeleccioTaulaProvider>(context, listen: false).reservasDia;

    return reservas == null
        ? FutureProvider<ReservasDia>(
            create: (_) {
              return Provider.of<SeleccioTaulaProvider>(context, listen: false)
                  .getReservasDia();
            },
            child: Consumer<ReservasDia>(builder: (_, value, __) {
              if (value == null) {
                return CircularProgressIndicator(strokeWidth: 4);
              } else {
                return CustomScrollViewTaules();
              }
            }),
          )
        : CustomScrollViewTaules();
  }
} */

class CustomScrollViewTaules extends StatelessWidget {
  const CustomScrollViewTaules({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor(int boto) {
      int tornActual =
          Provider.of<SeleccioTaulaProvider>(context, listen: false).torn;

      if (tornActual == boto) {
        return actionColor;
      } else {
        return Colors.grey[350];
      }
    }

    final TaulesList _taules =
        Provider.of<SeleccioTaulaProvider>(context, listen: false).taules;

    if (Provider.of<DiaProvider>(context, listen: true).connectionError &&
        _taules == null) {
      return Center(
        child: ErrorMessageWidget(),
      );
    } else if (_taules == null &&
        Provider.of<DiaProvider>(context, listen: true).connectionError ==
            false) {
      Provider.of<SeleccioTaulaProvider>(context, listen: true).setTaulesList();
      return SingleChildScrollView(
          child: Center(
              child: Container(
                  width: 40, height: 40, child: CircularProgressIndicator())));
    } else {
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
                        child: Consumer<SeleccioTaulaProvider>(
                          builder: (context, provider, _) => RaisedButton(
                            color: getColor(1),
                            child: Text(
                              "Turno 1",
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              Provider.of<SeleccioTaulaProvider>(context,
                                      listen: false)
                                  .changeTaulesList(1);
                            },
                          ),
                        ),
                      ),
                      Provider.of<SeleccioTaulaProvider>(context, listen: false)
                                  .servei ==
                              2
                          ? SizedBox(width: 20)
                          : Container(),
                      Provider.of<SeleccioTaulaProvider>(context, listen: false)
                                  .servei ==
                              1
                          ? Container()
                          : SizedBox(
                              height: 40,
                              width: 100,
                              child: Consumer<SeleccioTaulaProvider>(
                                builder: (context, provider, _) => RaisedButton(
                                  color: getColor(2),
                                  child: Text(
                                    "Turno 2",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onPressed: () {
                                    if (Provider.of<SeleccioTaulaProvider>(
                                                context,
                                                listen: false)
                                            .servei ==
                                        1) {
                                      null;
                                    } else {
                                      Provider.of<SeleccioTaulaProvider>(
                                              context,
                                              listen: false)
                                          .changeTaulesList(2);
                                    }
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
                return TaulaStackSelect(taula: _taules.taulesInfoList[index]);
              },
              childCount: _taules.taulesInfoList.length,
            ),
          )
        ],
      );
    }
  }
}

class TaulaStackSelect extends StatelessWidget {
  const TaulaStackSelect({
    Key key,
    @required this.taula,
  }) : super(key: key);

  final Taula taula;

  @override
  Widget build(BuildContext context) {
    return Provider<Taula>.value(
      value: taula,
      child: Container(
        width: 171,
        height: 130,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(10),
          child: TaulaSelectElement(),
        ),
      ),
    );
  }
}

class TaulaSelectElement extends StatelessWidget {
  const TaulaSelectElement({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: true);
    void toggleSelected(Taula taula) {
      bool isSelected = newReservaProvider.idTaula.contains(taula.id);
      if (isSelected == false && !taula.isreserva) {
        newReservaProvider.setNumComensalesSelected(
            taula.maxpersonas, taula.id);
      } else {
        debugPrint("ENTRA SEMPRE");
        if (!taula.isreserva) {
          newReservaProvider.unselectTaula(taula);
        }
      }
    }

    final taula = Provider.of<Taula>(context);
    return InkWell(
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        splashColor: actionColor,
        onTap: () {
          toggleSelected(taula);
        },
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TaulaInfoCardNom(),
                TaulaInfoCardCapacitat(),
                TaulaInfoCardId()
              ],
            ),
            newReservaProvider.idTaula.contains(taula.id) && !taula.isreserva
                ? Positioned(
                    bottom: 45,
                    left: 28,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: actionColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        size: 30,
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ));
  }
}

class InfoPreviewCard extends StatelessWidget {
  const InfoPreviewCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      newReservaProvider.getDia(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 30),
                    NumeroComensalesWidget(),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  newReservaProvider.servei == 1 ? "COMIDA" : "CENA",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NumeroComensalesWidget extends StatelessWidget {
  const NumeroComensalesWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: true);
    return Row(
      children: <Widget>[
        Icon(
          Icons.supervisor_account,
          color: Colors.black,
          size: 25,
        ),
        SizedBox(width: 5),
        Text(
          "${newReservaProvider.numComensalesSelected.toString()} /",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(width: 5),
        Text(
          newReservaProvider.numComensales.toString(),
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(width: 5),
        newReservaProvider.showMissingCamps &&
                newReservaProvider.numComensalesSelected <
                    newReservaProvider.numComensales
            ? Icon(Icons.announcement, color: Colors.red)
            : SizedBox(width: 2),
      ],
    );
  }
}
