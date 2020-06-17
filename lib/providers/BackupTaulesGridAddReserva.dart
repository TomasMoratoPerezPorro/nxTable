/* import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaulesGridAddReserva extends StatelessWidget {
  const TaulesGridAddReserva({
    Key key,
    @required this.servei,
    this.isAdding,
  }) : super(key: key);

  final int servei;
  final bool isAdding;

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
} */