import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:testgithub/src/models/detail_commit.dart';
import 'package:testgithub/src/models/repo.dart';
import 'package:testgithub/src/services/rest_service_client.dart';
import 'package:testgithub/src/services/rest_service_repository.dart';
import 'package:http/http.dart' as http;
import 'package:testgithub/src/utils/appstyle.dart';
import 'package:testgithub/src/utils/debug_utils.dart';

class ListCommitPage extends StatefulWidget {

  @override
  _ListCommitPageState createState() => _ListCommitPageState();
}

class _ListCommitPageState extends State<ListCommitPage> {
  /*Instanciamos la clase RestServiceRepository la cual actua de interface 
  hacia la clase de Servicios*/
  final RestServiceRepository restServiceRepository = RestServiceRepository(
    restServiceClient: RestServiceClient(httpClient: http.Client()),
  );

  @override
  Widget build(BuildContext context) {
    /*Instanciamos la clase AppStyleModeNotifier que se encarga del tema y colores, 
    este nos permite hacer el cambio a colores en tiempo real*/
    AppStyleModeNotifier appStyleMode =Provider.of<AppStyleModeNotifier>(context);
    List<String> involvedfiles = [
      '/lib/src/pages/list_commit.dart',
      '/lib/src/models/detail_commit.dart',
      '/lib/src/models/commit.dart',
      '/lib/src/models/author.dart',
      '/lib/src/services/rest_service_client.dart (getCommits())',
      '/lib/src/utils/*'
    ]; 

    return Scaffold(
      appBar: AppBar(
        title: Text('Commits',style: TextStyle(color: appStyleMode.primaryTextColor)),
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
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            debugInfo("_loadCommits","/lib/src/pages/list_commit",involvedfiles,context),//Llamamos al metodo debugInfo para poder mostrar la informacion de los archivos en UI
            Divider(color: Colors.grey),
            Expanded( 
              child: FutureBuilder( //Creamos un future builder que se encargara de traer los datos con getCommits y luego crear el listview
                future: restServiceRepository.getCommits(), 
                builder: _loadCommits,
              )
            )
          ],
        )
      )
    );
  }

  Widget _loadCommits(BuildContext context, AsyncSnapshot<List<DetailCommit>> commit){
    if(commit.connectionState == ConnectionState.done){ //Revisamos que haya traido data
      if(commit.hasError) //Verificamos si existio algun error, de ser el caso mostramos un error
        return Container(child: Text("Ocurrio un error", style: Theme.of(context).textTheme.subtitle));

      //Caso contrario creamos el listview con el listado de commits      
      return ListView.separated(
        shrinkWrap: true,
        itemCount: commit.requireData.length,
        separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey),
        itemBuilder: (BuildContext context, int index){
          return  GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: _datosCommit(commit.requireData[index]),
            onTap: (){
              Navigator.pushNamed(context, 'view', arguments: commit.requireData[index].sha);
            },
          );
        }
      );
    }
    else{
      return Center( child: CircularProgressIndicator());
    }
  }

  Widget _datosCommit(DetailCommit commit){
    final f = new DateFormat('dd/MM hh:mm');
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        CircleAvatar(
          minRadius: 30.0,
          backgroundImage: NetworkImage(commit.author.avatar_url),
        ),
        SizedBox(width: 20.0),
        Expanded( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(commit.commit.author.name, style: Theme.of(context).textTheme.subtitle),
              Text(commit.commit.message, style: Theme.of(context).textTheme.body2),
              Align(alignment: Alignment.bottomRight, child: Text(f.format(commit.commit.author.date.toLocal()), style: Theme.of(context).textTheme.body2, textAlign: TextAlign.end)),
            ],
          )
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, color: Colors.blue),
          onPressed: (){
            Navigator.pushNamed(context, 'view', arguments: commit.sha);
          },
        )
      ],
    );
  }

}
