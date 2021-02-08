import 'package:flutter/material.dart';
import '../pages/index.dart';
import '../pages/list_commit.dart';
import '../pages/view_commit.dart';

/*Definimos las rutas del aplicativo mediante nombres,
esto nos permite poder pasar de una pagina a otra de manera mas ordenada*/
Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/' : ( BuildContext context ) => IndexPage(),
    'list' : ( BuildContext context ) => ListCommitPage(),
    'view' : ( BuildContext context ) => ViewCommitPage(),
  };
}
