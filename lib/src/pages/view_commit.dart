import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:testgithub/src/models/detail_commit.dart';
import 'package:testgithub/src/models/github_file.dart';
import 'package:testgithub/src/services/rest_service_client.dart';
import 'package:testgithub/src/services/rest_service_repository.dart';
import 'package:http/http.dart' as http;
import 'package:testgithub/src/utils/appstyle.dart';
import 'package:testgithub/src/utils/debug_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewCommitPage extends StatefulWidget {

  @override
  _ViewCommitPageState createState() => _ViewCommitPageState();
}

class _ViewCommitPageState extends State<ViewCommitPage> {

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
    
    // Obtenemos la propiedad sha del commit de la pagina anterior, y con este traemos el listado de archivos modificados
    String sha = ModalRoute.of(context).settings.arguments;
    List<String> involvedfiles = [
      '/lib/src/pages/view_commit.dart',
      '/lib/src/models/detail_commit.dart',
      '/lib/src/models/commit.dart',
      '/lib/src/models/author.dart',
      '/lib/src/models/stats.dart',
      '/lib/src/models/files.dart',
      '/lib/src/services/rest_service_client.dart (getCommitDetail())',
      '/lib/src/utils/*'
    ]; 

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Commit',style: TextStyle(color: appStyleMode.primaryTextColor)),
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
        child: Container( 
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              debugInfo("_loadCommitsDetail","/lib/src/pages/view_commit",involvedfiles,context), //Llamamos al metodo debugInfo para poder mostrar la informacion de los archivos en UI
              Divider(color: Colors.grey),
              Expanded(
                child:FutureBuilder( //Creamos un future builder, para traer los archivos modificados, enviamos el parametro sha a github, y posteriormente creamos la vista
                  future: restServiceRepository.getCommitDetail(sha),
                  builder: _loadCommitsDetail,
                )
              )
            ],
          )
        )
      )
    );
  }

  Widget _loadCommitsDetail(BuildContext context, AsyncSnapshot<DetailCommit> commitdetail){
    if(commitdetail.connectionState == ConnectionState.done){ //Verificamos que se haya traido correctamente la data
      if(commitdetail.hasError){ //Verificamos si hubo algun error si es el caso mostramos un error
        return Container(child: Text("Ocurrio un error", style: Theme.of(context).textTheme.subtitle));
      }
      
      //Caso contrario creamos el listview con la data de los archivos
      return ListView.separated(
        shrinkWrap: true,
        itemCount: commitdetail.requireData.files.length,
        separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey),
        itemBuilder: (BuildContext context, int index){
          return  GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: _datosFiles(commitdetail.requireData.files[index]),
            onTap: (){ //Agregamos el evento de abrir los archivos modificados en el navegador
              launch(commitdetail.requireData.files[index].blob_url);
            },
          );
        }
      );
    }
    else{
      return Center( child: CircularProgressIndicator());
    }
  }

  Widget _datosFiles(GithubFile file){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(Icons.file_copy, size: 40.0, color: Colors.blue),
        SizedBox(width: 20.0),
        Expanded( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(file.filename, style: Theme.of(context).textTheme.subtitle),
              Text(file.status, style: TextStyle(color: file.status == 'added' ? Colors.green : Colors.yellow)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.add, color: Colors.green),
                  Text(file.additions.toString(), style: Theme.of(context).textTheme.subtitle),
                  Icon(Icons.swap_horiz, color: Colors.yellow),
                  Text(file.changes.toString(), style: Theme.of(context).textTheme.subtitle,),
                  Icon(Icons.delete, color: Colors.red),
                  Text(file.deletions.toString(), style: Theme.of(context).textTheme.subtitle,)
                ],
              ),
            ],
          )
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, color: Colors.blue),
          onPressed: (){
            launch(file.blob_url);
          },
        )
      ],
    );
  }

}
