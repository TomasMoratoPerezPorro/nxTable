import 'package:flutter/material.dart';
import 'package:prototip_tfg/pages/NewReservaSecondStep.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:prototip_tfg/providers/SeleccioTaulaProvider.dart';
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
        NewReservaSecondStep(),
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
                              if (bottomSelectedIndex == 1) {
                                newReservaProvider.resetDataStep2();
                              }
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
                              if (newReservaProvider
                                  .canProceed(bottomSelectedIndex))
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
      ),
    );
  }
}
