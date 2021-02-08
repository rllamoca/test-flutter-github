import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testgithub/src/models/detail_commit.dart';
import 'package:testgithub/src/models/repo.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../main.dart';


class RestServiceClient {
  //Definimos la url base para nuestras peticiones
  final String ruta = 'https://api.github.com/repos/rllamoca/test-flutter-github';
  //Definimos nuestros headers, los cuales permitiran traer la data de github como json
  Map<String, String> headers;
  //Instanciamos nuestro cliente http
  final http.Client httpClient;

  //Inicializamos
  RestServiceClient({
    this.httpClient
  }){
    headers = {
      HttpHeaders.contentTypeHeader: 'application/json', // or whatever
    };
  }

  //Este metodo permite hacer peticiones get, teniendo como parametro una ruta, devuelve la data en String
  Future<String> doGet(String route) async {
    try{
      final response = await http.get(ruta+route,headers: headers).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load tips');
      }
    } on TimeoutException catch (e) {
        mostrarErrorConexion(e);
        throw Exception('Failed to load tips');
    } on SocketException catch (e) {
        mostrarErrorConexion(e);
        throw Exception('Failed to load tips');
    }
  }

  /*Este metodo obtiene la informacion del repositorio, utilizando el metodo doGet, 
  hace el parseo a las clase Repo desde el json obtenido*/
  Future<Repo> getRepoInfo() async {
    return Repo.fromJson(json.decode(await doGet("")));
  }

  /*Este metodo obtiene la informacion el listado de commits del proyecto, utilizando el 
  metodo doGet, hace el parseo a las clase DetailCommit desde el json obtenido*/
  Future<List<DetailCommit>> getCommits() async {
    Iterable list = json.decode(await doGet("/commits"));
    return list.map((model) => DetailCommit.fromJson(model)).toList();
  }

  /*Este metodo obtiene la informacion de un commit especifico, utilizando el 
  metodo doGet, hace el parseo a las clase DetailCommit desde el json obtenido*/
  Future<DetailCommit> getCommitDetail(String sha) async {
    return DetailCommit.fromJson(json.decode(await doGet("/commits/"+sha)));
  }

  /*Este metodo nos permite mostrar un popup con el mensaje de error de conexion,
  en el caso de un fallo de red*/
  void mostrarErrorConexion(e){
    showDialog(
      context: navigatorKey.currentState.overlay.context, // Using overlay's context
      builder: (context) => Center(
        child: AlertDialog(
            shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(16.0)
            ),
            content: Text('Hubo un problema de conexión, revisa tu conexión a internet e intentalo nuevamente', textAlign: TextAlign.center),
          )
      )
    );
  }

}
