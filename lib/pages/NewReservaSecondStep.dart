import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/ReservasDia.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:prototip_tfg/providers/DiaProvider.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:prototip_tfg/providers/SeleccioTaulaProvider.dart';
import 'package:prototip_tfg/providers/ServeiProvider.dart';
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
}

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
        Provider.of<SeleccioTaulaProvider>(context, listen: true).taules;
    if (_taules == null) {
      Provider.of<SeleccioTaulaProvider>(context, listen: true).setTaulesList();
      return CircularProgressIndicator();
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
                      SizedBox(width: 10),
                      SizedBox(
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
                              Provider.of<SeleccioTaulaProvider>(context,
                                      listen: false)
                                  .changeTaulesList(2);
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
          newReservaProvider.numComensales.toString(),
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
