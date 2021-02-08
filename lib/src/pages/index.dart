import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:testgithub/src/models/repo.dart';
import 'package:testgithub/src/services/rest_service_client.dart';
import 'package:testgithub/src/services/rest_service_repository.dart';
import 'package:http/http.dart' as http;
import 'package:testgithub/src/utils/appstyle.dart';
import 'package:testgithub/src/utils/debug_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  /*Instanciamos la clase RestServiceRepository la cual actua de interface 
  hacia la clase de Servicios*/
  final RestServiceRepository restServiceRepository = RestServiceRepository(
    restServiceClient: RestServiceClient(httpClient: http.Client()),
  );

  /*Instanciamos la clase AppStyleModeNotifier que se encarga del tema y colores, 
  este nos permite hacer el cambio a colores en tiempo real*/
  AppStyleModeNotifier appStyleMode;
  
  @override
  Widget build(BuildContext context) {
    appStyleMode =Provider.of<AppStyleModeNotifier>(context);
    List<String> involvedfiles = [
      '/lib/src/pages/index.dart',
      '/lib/src/models/repo.dart',
      '/lib/src/models/owner.dart',
      '/lib/src/services/rest_service_client.dart (getRepoInfo())',
      '/lib/src/utils/*'
    ]; 
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Proyecto Github',style: TextStyle(color: appStyleMode.primaryTextColor)),
        backgroundColor: appStyleMode.appBarBackgroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              setState((){});
            },
          )
        ],
      ),
      body: Container( 
        height: double.infinity,
        color: appStyleMode.primaryBackgroundColor,
        child: SingleChildScrollView( 
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              debugInfo("_loadProfile","/lib/src/pages/index.dart",involvedfiles,context), //Llamamos al metodo debugInfo para poder mostrar la informacion de los archivos en UI
              Divider(color: Colors.grey),
              FutureBuilder( //Creamos un future builder para traer la info del repositorio, y posteriormente crear la vista
                future: restServiceRepository.getRepoInfo(),
                builder: _loadProfile,
              )
            ],
          )
        )
      )
    );
  }

  Widget _loadProfile(BuildContext context, AsyncSnapshot<Repo> repo){
    if(repo.connectionState == ConnectionState.done){ //validamos que los datos hayan sido traidos
      if(repo.hasError) //verificamos si hubo algun error al traer los datos
        return Container(child: Text("Ocurrio un error", style: Theme.of(context).textTheme.subtitle));

      return _showRepo(repo.requireData);
    }
    else{
      return Center( child: CircularProgressIndicator());
    }
  }

  Widget _showRepo(Repo info){
    return 
    Column(
      children: [
        Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _topContainer(info),
                _bottomContainer(info)
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundImage: NetworkImage(info.owner.avatar_url),
                ),
              )
            ),
          ],
        ),
        SizedBox(height: 40.0),
        Container(
          child: _actionButtons(info),
          alignment: Alignment.bottomCenter,
        ),
        SizedBox(height: 20.0),
        SwitchListTile(
          title: Text("Modo dark", style: Theme.of(context).textTheme.subtitle),
          value: appStyleMode.mode,
          onChanged: (value)=> appStyleMode.switchMode(),
        ),
    ]);
  }

  Widget _topContainer(Repo repo){
    return 
        Container(
          height: 200.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
            color: Colors.blue,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2.0, 10.0)
              )
            ]
          ),
          child: Container(
            padding: EdgeInsets.only(top: 30.0),
            alignment: Alignment.topCenter, 
            child: Column(
              children: [
                  Text(repo.name, style: Theme.of(context).textTheme.title),
                  SizedBox(height: 10.0),
                  repo.private ? Icon(Icons.lock) : Icon(Icons.lock_open),
                  SizedBox(height: 10.0),
                  Text(repo.owner.login),
              ],
            )
          )
        );
  }

  Widget _bottomContainer(Repo repo){
    final f = new DateFormat('dd/MM/yyyy hh:mm');
    return 
      Container(
          height: 200.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2.0, 10.0)
              )
            ]
          ),
          child: Container(
            padding: EdgeInsets.only(top: 130.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("Actualización", style: Theme.of(context).textTheme.subtitle, textAlign: TextAlign.center),
                  Text(f.format(repo.pushed_at.toLocal()), style: Theme.of(context).textTheme.body2, textAlign: TextAlign.center)
                ]
              ),
              Column(
                children: [
                  Text("Lenguaje", style: Theme.of(context).textTheme.subtitle, textAlign: TextAlign.center),
                  Text(repo.language, style: Theme.of(context).textTheme.body2, textAlign: TextAlign.center)
                ]
              )
            ],
          )),
        );
  }

  Widget _actionButtons(Repo repo){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
          ),
          child: 
          Column(
            children: [
              Icon(Icons.cloud,size: 40.0),
              Text("Web")
            ]
          ),
          onPressed: (){
            launch(repo.html_url);
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
          ),
          child: 
          Column(
            children: [
              Icon(Icons.comment,size: 40.0),
              Text("Commits")
            ]
          ),
          onPressed: (){
            Navigator.pushNamed(context, 'list');
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
          ),
          child: 
          Column(
            children: [
              Icon(Icons.person,size: 40.0),
              Text("Perfil")
            ]
          ),
          onPressed: (){
            launch(repo.owner.html_url);
          },
        ),
      ],
    );
  }
}
