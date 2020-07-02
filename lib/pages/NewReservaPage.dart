import 'package:flutter/material.dart';
import 'package:prototip_tfg/pages/NewReservaConfirmationStep.dart';
import 'package:prototip_tfg/pages/NewReservaSecondStep.dart';
import 'package:prototip_tfg/pages/NewReservaThirdStep.dart';
import 'package:prototip_tfg/providers/DiaProvider.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:prototip_tfg/providers/SeleccioTaulaProvider.dart';
import 'package:prototip_tfg/widgets/newReservaPageWidgets/Dialogs.dart';
import 'package:prototip_tfg/widgets/newReservaPageWidgets/NewReservaFirstStep/NewReservaFirstStep.dart';
import 'package:provider/provider.dart';

import '../global.dart';

class NewReservasPage extends StatefulWidget {
  @override
  _NewReservasPageState createState() => _NewReservasPageState();
}

class _NewReservasPageState extends State<NewReservasPage> {
  int bottomSelectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: false,
  );

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  Widget buildPageView() {
    return PageView(
      physics: new NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        NewReservaFirstStep(),
        NewReservaSecondStep(),
        NewReservaThirdStep(),
        NewReservaConfirmationStep(),
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

  Future<void> _handleSubmit(BuildContext context) async {
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: false);
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);
      await newReservaProvider.saveReserva();
      await Provider.of<DiaProvider>(context, listen: false).refreshDay();
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
          .pop(); //close the dialoge
      Navigator.pop(context);
      /* Navigator.pushReplacementNamed(context, "/home"); */
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: false);
    return ChangeNotifierProxyProvider<NewReservaProvider,
        SeleccioTaulaProvider>(
      create: (context) => SeleccioTaulaProvider(),
      update: (_, newReservaProvider, seleccioTaulaProvider) =>
          seleccioTaulaProvider..update(newReservaProvider),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Nueva Reserva'),
          backgroundColor: mainColor,
        ),
        floatingActionButton: bottomSelectedIndex == 3
            ? FloatingActionButton(
                foregroundColor: Colors.black,
                backgroundColor: actionColor,
                child: const Icon(
                  Icons.check,
                  size: 30,
                ),
                onPressed: () => _handleSubmit(context))
            : null,
        /* floatingActionButton: FloatingActionButton(onPressed: (){}), */
        bottomNavigationBar: BottomAppBar(
            color: mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                bottomSelectedIndex == 0
                    ? SizedBox(
                        height: 35,
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          onTap: () {
                            if (bottomSelectedIndex > 0) {
                              if (bottomSelectedIndex == 1) {
                                newReservaProvider.resetDataStep2();
                              }
                              bottomTapped(bottomSelectedIndex - 1);
                            }
                          },
                          child: Icon(Icons.arrow_back,
                              size: 25, color: Colors.white),
                        ),
                      ),
                SizedBox(
                  height: 35,
                ),
                bottomSelectedIndex == 3
                    ? SizedBox(
                        height: 35,
                      )
                    : Builder(
                        builder: (context) => Container(
                          height: 50,
                          width: 50,
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            onTap: () {
                              if (bottomSelectedIndex < 3) {
                                if (newReservaProvider
                                    .canProceed(bottomSelectedIndex)) {
                                  newReservaProvider.setMissingCamps(false);
                                  bottomTapped(bottomSelectedIndex + 1);
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Padding(
                                      padding: const EdgeInsets.all(7),
                                      child: Text(bottomSelectedIndex == 1
                                          ? 'El número de comensales excede la capacidad de la mesa, añada otra mesa'
                                          : 'Introduce todos los campos para continuar'),
                                    ),
                                    duration: Duration(seconds: 3),
                                  ));
                                }
                              }
                            },
                            child: Icon(Icons.arrow_forward,
                                size: 25, color: Colors.white),
                          ),
                        ),
                      ),
              ],
            )),
        body: buildPageView(),
      ),
    );
  }
}
