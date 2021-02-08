import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testgithub/src/pages/list_commit.dart';
import 'package:testgithub/src/routes/routes.dart';

import 'src/pages/index.dart';
import 'src/utils/appstyle.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStyleModeNotifier()), //Añadimos el provider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  var rutainicial = '/';
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: rutainicial, //Definimos la ruta inicial
      routes: getApplicationRoutes(), //Instanciamos las rutas de la app
      title: 'GitHub Demo FulltimeForce', 
      onGenerateRoute: ( RouteSettings settings ){
        return MaterialPageRoute(
          builder: ( BuildContext context ) => IndexPage()
        );
      },
      theme: ThemeData( //Definimos parametros del tema inicial
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white),
          body2: TextStyle(color: Colors.grey[400]),
          title: TextStyle(
            color: Colors.white,
            fontSize: 20.0
          ),
          subtitle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0
          )
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey
    );
  }
}
