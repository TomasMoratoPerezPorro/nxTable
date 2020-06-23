import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:prototip_tfg/global.dart';
import 'package:prototip_tfg/providers/ServeiProvider.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/TaulaStack.dart';
import 'package:provider/provider.dart';

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
      Provider.of<ServeiProvider>(context).setTaulesList();
      return Center(child: CircularProgressIndicator());
    } else {
      final TaulesList _taules = Provider.of<ServeiProvider>(context).taules;
      return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: Container(),
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
                                .changeTaulesList(1);
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
                                .changeTaulesList(2);
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