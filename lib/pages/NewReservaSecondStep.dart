import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:prototip_tfg/pages/NewReservaPage.dart';
import 'package:prototip_tfg/pages/MainPage.dart';
import 'package:prototip_tfg/providers/DiaProvider.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:prototip_tfg/providers/ServeiProvider.dart';
import 'package:provider/provider.dart';

final Color mainColor = const Color.fromARGB(255, 44, 64, 114);
final Color bgColor = const Color.fromARGB(255, 248, 246, 242);
final Color actionColor = const Color.fromARGB(255, 255, 210, 57);
final Color disabledColor = const Color.fromARGB(50, 153, 153, 153);




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
    return ChangeNotifierProxyProvider<DiaProvider, ServeiProvider>(
        create: (_) => ServeiProvider(1, 1),
        update: (_, diaProvider, serveiProvider) =>
            serveiProvider..update(diaProvider),
        child: TaulesGridAddReserva(
          servei: 1,
        ));
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
      Provider.of<ServeiProvider>(context).setTaulesList();
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
                                  .changeTaulesList(1);
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
