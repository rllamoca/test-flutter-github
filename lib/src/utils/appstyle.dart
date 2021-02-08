import 'package:flutter/material.dart';

/*Esta clase actua como Provider, permite notificar a todas las paginas del stack,
que se hace un cambio de estilo a toda la aplicacion de esta forma podemos hacer cambio de 
tema en tiempo real, sin necesidad de re abrir el aplicativo*/
class AppStyleModeNotifier extends ChangeNotifier {
  bool mode = false; //false light , true dark
  Color primaryBackgroundColor = Colors.white;
  Color appBarBackgroundColor = Colors.cyan[200];
  Color boxColor = Colors.blue[50];
  Color boxTextColor = Colors.indigo;
  Color primaryTextColor = Colors.white;
  Color dashboardColor = Colors.cyan;
  Color dashboardTextColor = Colors.red[600];
  Color dashboardIconColor = Colors.yellow[200];

  switchMode() {
    if (mode == true) {
      primaryBackgroundColor = Colors.white;
      appBarBackgroundColor = Colors.cyan[200];
      boxColor = Colors.tealAccent;
      boxTextColor = Colors.indigo;
      primaryTextColor = Colors.white;
      dashboardColor = Colors.cyan;
      dashboardTextColor = Colors.red[600];
      dashboardIconColor = Colors.yellow[200];
      mode = false;
    } else {
      primaryBackgroundColor = Colors.grey[900];
      primaryTextColor = Colors.blue;

      appBarBackgroundColor = Colors.grey[800];
      boxColor = Colors.black;
      boxTextColor = Colors.grey[100];
      dashboardColor = Colors.grey[900];
      dashboardTextColor = Colors.grey[400];
      dashboardIconColor = Colors.white;
      mode = true;
    }

    notifyListeners(); //Esta funcion permite que se actualice la UI
  }
}