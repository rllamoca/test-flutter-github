import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appstyle.dart';

/*Este archivo contiene funciones o metodos que devuelven widgets genericos, usados
en el aplicativo, evitando duplicidad de codigo*/

Widget debugInfo(String funcion, String nomarchivo, List<String> detalle, BuildContext context){
  AppStyleModeNotifier appStyleMode =Provider.of<AppStyleModeNotifier>(context);
  return Row(
    children: [
      Expanded( 
        child: Text("Cargando función " + funcion + " en el archivo " + nomarchivo, style: Theme.of(context).textTheme.body2)
      ),
      ElevatedButton(
        child: Text("Ver más..."),
        onPressed: (){
          showDialog(
            context: context, // Using overlay's context
            builder: (context) => Center(
              child: AlertDialog(
                  backgroundColor: appStyleMode.primaryBackgroundColor,
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: appStyleMode.primaryBackgroundColor),
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _obtenerDetalle(detalle,context),
                  )
//                  content: Text('', textAlign: TextAlign.center),
                )
            )
          );
        },
      )
    ],
  );
}

List<Widget> _obtenerDetalle(List<String> detalle,context){
  List<Widget> ret = [];
  ret.add(Center(child: Text("Archivos Involucrados",style: Theme.of(context).textTheme.body2)));
  detalle.forEach((element)=>{
    ret.add(ListTile(leading: Icon(Icons.circle), title: Text(element, style: Theme.of(context).textTheme.body2)))
  });
  return ret;
}